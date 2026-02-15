Return-Path: <netdev+bounces-258810-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AMSiJRpFkmlysgEAu9opvQ
	(envelope-from <netdev+bounces-258810-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 15 Feb 2026 23:13:46 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id CDB6F13FE0F
	for <lists+netdev@lfdr.de>; Sun, 15 Feb 2026 23:13:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 5B77B3007225
	for <lists+netdev@lfdr.de>; Sun, 15 Feb 2026 22:13:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C69330ACF2;
	Sun, 15 Feb 2026 22:13:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="CkzHYDqI"
X-Original-To: netdev@vger.kernel.org
Received: from mail-oa1-f43.google.com (mail-oa1-f43.google.com [209.85.160.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10DCE3054C7
	for <netdev@vger.kernel.org>; Sun, 15 Feb 2026 22:13:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771193612; cv=none; b=Iiuh6+MSXsxTnJ4EpuxYF2epq4d1w8WC6HwOTiJfP9QDX5lN3eXDzOjJQgmFGDxC07UoopnkPGo4WEDV4IIqB6Tn3mhHcyRbCPoUtSsRRvLGOjL4wgBHIF8Qyagyby+r5TU6c3xhdJqvRBbb1CViGkZXRz1uwCR3Ijw2Ys6a1kQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771193612; c=relaxed/simple;
	bh=YnSHyuORvjP1DdDcwkSrXSvWFLgo0jHLdV/qdwBTdhU=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=EX2ETyCT8Q1/2aVPFNzeIeW1UR5yMWhasRnoDy8KIcRWvAzFRRgl3S6p8EnsCOIZSuzSxIZWw3PsGUDNiKpe/7yhENqOXdNYKHH7WJQSOSxq9ey8C0uMR7sCTaCT4+7tERV4BWzVOrQVFJjvAvFkbeb/yTu8iMu2s9qjpuL0fgc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=CkzHYDqI; arc=none smtp.client-ip=209.85.160.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-oa1-f43.google.com with SMTP id 586e51a60fabf-40f095f1036so1194143fac.1
        for <netdev@vger.kernel.org>; Sun, 15 Feb 2026 14:13:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1771193610; x=1771798410; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0Q5I5/fxr4SnEoRzTQ9BTMDNBCJMEhLFbjF/WzpJaZA=;
        b=CkzHYDqIde0ulfBmhNwFpvczmixhEzapr18FjFEgmha4zEkAZLSbhpYNe1CBHjU5kG
         PeoxPdfhDptct35FTGNrtiulQ63xaY6GWUdDd9JuPeXZFaeNRPmQqzu+ENTjMCUbHfSZ
         G4Pmqr+Dafq8ENUm+UD9VuQRK5Y+22ZjBieG4cjQZqoSVvj+1m8QiFJsxk14zM1Yy5zX
         b+IpxZnE49SofIxtPRfwK0OKa+vuly9FkXu4FuqGGearBJMRhtKkooEStfItuPIz533z
         2RSKrdJacy67VJVVx3X71ajVkYUN/hsvfrDoS/o7zYaAQKOm/hUeFgXQqnF9OA3inMkp
         k8Aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771193610; x=1771798410;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=0Q5I5/fxr4SnEoRzTQ9BTMDNBCJMEhLFbjF/WzpJaZA=;
        b=eFi1LC8W/4XnKan/f44O3TILOSCYIxA39GwIU93wfUSXpOAv9a+Bn/8ObDesLOvmxy
         C0xga7eUuHvDWbbV4CRRoc+64r1r21B0ObG+ZqBZWRET33tGXD9YO2hm2L6t3gcmjn4y
         JO/Fr8hPaklk+Su66g9SvSaeXWe/Dp8jnLsTeews6zvYaXdCQ9UrOW6H6jfEb2KB0kGw
         Y0fojbz5LnP1tBau27Y0T81AuRCwnfORSCSokE7JPx1cYuCvZqIBQCndI2cTvhv/181w
         GfojrIktal9oZtXGrmgRX25Hs7Cv9JTItW6wEO/4pIMB2tOSGQEFiBbu4qLqhw64qnhq
         JvPQ==
X-Gm-Message-State: AOJu0Yw91J6abcMdWhXaNRo4fLhJP9qluHJsLOJJoqvL6i/zhzO6W+QY
	tBL/6MOZTOxygxbtmntmDv93asM+qJFERwVNCj26jME7ULRsZIkg2POpGn8Ju6VM117UJ/9Rmgz
	bif1B
X-Gm-Gg: AZuq6aKBSyOAOtIwsiEjcO2t0tTMmd+LQ1Le9AGm8JPt536huIdUCyj9KXRNbhXKwpJ
	gcvNkkpPDX97AQ6USYyFg5LZWDpy/dDtLJ5+h5DFuWG1IGMhlx65UVu2MoS3q8c2BKB+dexzhKL
	Sj1xSrYmBqnb7IxWHwX1qPVMRVt6sSm1iAImXR8Q0KU5nrNOzeke7g4J66h8u0+DlM4UVXwV9Ed
	up6juoek+auKZJY0CVfE+MtNSz5p8OmgFqEKVsTj19phE69D+CBkVlZ+ifP8htbw5u3Rc+wnDSd
	dvaHfCkof0pqFb02eFJMIBEana2pU+OP0GYNQRqKY6TLv+J0743L0NHdRmRvYAmP4p368nIYE4D
	jG1gPew6ZBNVZ5Dm9JHMymYjRQQWW4jbHabLo6734Q/HSdphVlb21TK9v1XfgLJpjUBdxtvQezu
	h0Qij1wUI5jIV9VtMxx0S3eUTmf8OFA2vvxs/IMEL1m9SOeOryY/2FCKFS3uhwxMxa23GPJWlEb
	n1x
X-Received: by 2002:a05:6871:230c:b0:3ec:2fa7:8180 with SMTP id 586e51a60fabf-40eee51d142mr5286854fac.0.1771193609962;
        Sun, 15 Feb 2026 14:13:29 -0800 (PST)
Received: from [127.0.0.1] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-40eaf178c1fsm13191922fac.17.2026.02.15.14.13.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 Feb 2026 14:13:29 -0800 (PST)
From: Jens Axboe <axboe@kernel.dk>
To: io-uring@vger.kernel.org, Pavel Begunkov <asml.silence@gmail.com>
Cc: netdev@vger.kernel.org
In-Reply-To: <2e8280467c93ead0c61ed3d68c036d6a0474bb78.1771188227.git.asml.silence@gmail.com>
References: <2e8280467c93ead0c61ed3d68c036d6a0474bb78.1771188227.git.asml.silence@gmail.com>
Subject: Re: [PATCH io_uring-7.0] io_uring/query: return support for custom
 rx page size
Message-Id: <177119360871.79392.10892699946544286880.b4-ty@kernel.dk>
Date: Sun, 15 Feb 2026 15:13:28 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[kernel-dk.20230601.gappssmtp.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	DMARC_NA(0.00)[kernel.dk];
	FREEMAIL_TO(0.00)[vger.kernel.org,gmail.com];
	TAGGED_FROM(0.00)[bounces-258810-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	RCPT_COUNT_THREE(0.00)[3];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[axboe@kernel.dk,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel-dk.20230601.gappssmtp.com:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[kernel.dk:mid,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,kernel-dk.20230601.gappssmtp.com:dkim]
X-Rspamd-Queue-Id: CDB6F13FE0F
X-Rspamd-Action: no action


On Sun, 15 Feb 2026 21:34:28 +0000, Pavel Begunkov wrote:
> Add an ability to query if the zcrx rx page size setting is available.
> 
> Note, even when the API is supported by io_uring, the registration can
> still get rejected for various reasons, e.g. when the NIC or the driver
> doesn't support it, when the particular specified size is unsupported,
> when the memory area doesn't satisfy all requirements, etc.
> 
> [...]

Applied, thanks!

[1/1] io_uring/query: return support for custom rx page size
      commit: c29214677a9fc1a3a4ee65e189afeb5fd10d676f

Best regards,
-- 
Jens Axboe




