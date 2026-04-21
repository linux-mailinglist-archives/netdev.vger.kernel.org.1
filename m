Return-Path: <netdev+bounces-280135-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0CFxJNuE52m+9gEAu9opvQ
	(envelope-from <netdev+bounces-280135-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 21 Apr 2026 16:08:27 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E08943BC59
	for <lists+netdev@lfdr.de>; Tue, 21 Apr 2026 16:08:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DD54C3022F94
	for <lists+netdev@lfdr.de>; Tue, 21 Apr 2026 13:58:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E4523D75B5;
	Tue, 21 Apr 2026 13:58:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20251104.gappssmtp.com header.i=@kernel-dk.20251104.gappssmtp.com header.b="d5hH2Ee4"
X-Original-To: netdev@vger.kernel.org
Received: from mail-oo1-f50.google.com (mail-oo1-f50.google.com [209.85.161.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C18BC3D666F
	for <netdev@vger.kernel.org>; Tue, 21 Apr 2026 13:58:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776779895; cv=none; b=QCZDz/xFCv8wTwwg887LSTbqgFv2zMENmpfeTTYWkM9pky6XXlP4C//1KLoFIkLbGb4VyGEgus2EQGu0bBqA0ESLlDF+XeVeIlsXNjlVWVoz5RMNvMW1q+tLbDAeIsquaNcN2yqPykekq+VrP48NMjRD9KEc4Rw+VQcsBXFNeMc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776779895; c=relaxed/simple;
	bh=h79PSbg/IUermI8GVLDR2GFVPUmxoadUkF2GldaCZoQ=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=nrAXUSqsKbfvCD0SHrziWS6Zi64JxZEiHY8H2Ja8SEn0/ucPGzp0cMq8gHrXb6f7G1VNZBPIOZ3shFg14EYNsEh2/rhsF9i76iT6w/2vkzJW4eOjVdTPc3D/yypl7XF1lDz/BBJwodhZxQSrzw6WWIFuWBr6urVw0dIheOVhwzc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20251104.gappssmtp.com header.i=@kernel-dk.20251104.gappssmtp.com header.b=d5hH2Ee4; arc=none smtp.client-ip=209.85.161.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-oo1-f50.google.com with SMTP id 006d021491bc7-688a8e5fe5eso2020042eaf.1
        for <netdev@vger.kernel.org>; Tue, 21 Apr 2026 06:58:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20251104.gappssmtp.com; s=20251104; t=1776779893; x=1777384693; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7JNGZDDJHB9Ki23I1vuWlnb/tBBT2Wz3AVfTrWTmwcA=;
        b=d5hH2Ee4dTVdm9yENqC7RbDAuPbI0fnnB5oAsViaZvAUjO0qcfW9FjN8ogIywISPie
         m5kBdEhwEB0cqQo5mKJG+0Ddz2+pUTPQe2qmmEMbuOpIQzTOpPdKNFw74jEofK9IXJlt
         NqCfoYqSLysXrHQAob5CrRqX3NlM3W9vTAWUrNSWeMKMk1xPhXyWivk++W6S05UYluRG
         eTWv6++oa5Wi5STjg7w8fwhqbk6+QqXlcOl5DBEmN0tt7MK0SynREhWyf5jSr85YgXUl
         F7rb1tVTSpO0GW74mjPbJ67C2mTYagzox+hRMU7v2oBuhhYZRcW/Y6L/NN/BgWKkcOHo
         XW1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776779893; x=1777384693;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=7JNGZDDJHB9Ki23I1vuWlnb/tBBT2Wz3AVfTrWTmwcA=;
        b=eQ9aQrlbTTtvUTDX+J3+kkm8zGlTLim+1uUuGyYKaAsNQcw5X2+XHLNuEhvCejVA6f
         dzQdy+SrfbnhmRvJrIOIHGjTHvErlasdfB5bFVgm9Fiaz7SEBHJExK4vbq/tJ/B33O5F
         4hzFSdWvoFUs8jW9/6m9+FS/s1Gbq3cooPFD2Edi8RQea41RM0vf8b1mgkdlsCshncCh
         t938cglijScFSzu3UUPDe7LSFHp518Vyv2M4eEnLUtv+Y2tg2gO+YINgw6u/kWKpKy5r
         skTIwfCPCehdmhSeDlJiDDwkDZbBWhD6Pygnb7pgOnvP5dzSNM1TKq284OeA7/sW2bfl
         d2XA==
X-Gm-Message-State: AOJu0YxJ52k9Mm3i57rlYIE0H9ng1ZH5IAa4GBCUp4zDSX9f6g9arNmc
	NXmVU+VCC07kYfNgFl3nMiqIbEsoin63L41o7JPgPK9WmJxqLbufOmNqaoWfJs+vzxuYnjJQTgJ
	FTRLqPz4=
X-Gm-Gg: AeBDiesRY2843sEaM3BF5pa+vuyVlueFIYlwoEtaPibxZOG5S3O7tFW87icRy3r3iOp
	o2tYVpX0wmWmW3l7iZhUL3GHYinpyZecFyx/js89hMV9F1BGmedxdt1U0Lzx5ozGHprEcwmOduV
	5OfhAkTcreSqPp+9mjbETtaLVYOmJ5bO4kblJmqid40zF7orHxaMrkGbBw7zY/9qeIDZHOjzGrs
	q+x4sSp1R722ul2G2h0ea+e/afdU9pbrMba2cyyrBbh38WVfs5b7snfIcjmvm30PL5vbAQwr1l+
	YNdbi0+4PIP6UqOwpcEsN5d5v6EC7Pmiz2qOMVG/SZeUooEmVCtySm1itF6uD3gIqckUQ8ZMLZt
	Lxb4vmxFibd1BDkfMTaFnTYH2l6BwP9wIwytQpZAEsJAagJ3iY9v6An/wf2u7mApitj+4rA0Wv0
	tokAnnvzqu4sPDPKCicCTfsPtxpJztuG0wmCOI4yUIJK7xuXiTZa6J2sKeNm9Efj7hq3XlFDb+E
	Dss1KrhXjwDj2M=
X-Received: by 2002:a05:6820:2901:b0:694:9d3d:e040 with SMTP id 006d021491bc7-6949d3de22cmr704907eaf.31.1776779892805;
        Tue, 21 Apr 2026 06:58:12 -0700 (PDT)
Received: from [127.0.0.1] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-694984114f5sm1229359eaf.7.2026.04.21.06.58.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Apr 2026 06:58:12 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: io-uring@vger.kernel.org, Pavel Begunkov <asml.silence@gmail.com>
Cc: netdev@vger.kernel.org
In-Reply-To: <e560ae00960d27a810522a7efc0e201c82dff351.1776760917.git.asml.silence@gmail.com>
References: <e560ae00960d27a810522a7efc0e201c82dff351.1776760917.git.asml.silence@gmail.com>
Subject: Re: [PATCH 1/1] io_uring/zcrx: fix user_struct uaf
Message-Id: <177677989210.583761.13165622082638162638.b4-ty@b4>
Date: Tue, 21 Apr 2026 07:58:12 -0600
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15.2
X-Spamd-Result: default: False [-1.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[kernel-dk.20251104.gappssmtp.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[vger.kernel.org,gmail.com];
	TAGGED_FROM(0.00)[bounces-280135-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DMARC_NA(0.00)[kernel.dk];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[axboe@kernel.dk,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel-dk.20251104.gappssmtp.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,kernel-dk.20251104.gappssmtp.com:dkim]
X-Rspamd-Queue-Id: 3E08943BC59
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


On Tue, 21 Apr 2026 09:47:04 +0100, Pavel Begunkov wrote:
> io_free_rbuf_ring() usees a struct user_struct, which
> io_zcrx_ifq_free() puts it down before destroying the ring.

Applied, thanks!

[1/1] io_uring/zcrx: fix user_struct uaf
      commit: 17a2407de81bf3ef450fddb89230ac10141be110

Best regards,
-- 
Jens Axboe




