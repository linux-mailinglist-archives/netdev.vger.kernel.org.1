Return-Path: <netdev+bounces-281465-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4OU9EHm872mLFQEAu9opvQ
	(envelope-from <netdev+bounces-281465-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 27 Apr 2026 21:43:53 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id AF85D479747
	for <lists+netdev@lfdr.de>; Mon, 27 Apr 2026 21:43:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 97D03301DEEC
	for <lists+netdev@lfdr.de>; Mon, 27 Apr 2026 19:43:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74458391505;
	Mon, 27 Apr 2026 19:43:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="W04Ii0io"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com [209.85.208.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22ECD1D5170
	for <netdev@vger.kernel.org>; Mon, 27 Apr 2026 19:43:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777319028; cv=none; b=HB/VAt8q6YQhfysbIRqDC72APg+PW73gVGcoB3poLH2CbmvNFyPPiMPzszwiPnxIeqzK5LzkSUCRgE3i+Y0EplyPMXliieZqD3jiR/CM52Wkxa3dirU1xQV5K+55GdDA2MUZJPVXxZIQK14HdzpefO2zt+ErhDYYFitVNDgNNYI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777319028; c=relaxed/simple;
	bh=vnKbSNDgIZcO0kazMykgvUSVqvxbhcx6hIO6cZb+QgA=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=THOviPC3xTzwarB2+U92UZeweqGOAngxAj2b2XEjR2U6zpcsXdqhGpeYJab5giRFsMUAWemdllpKSNwOu9ADP3uxE7tE6FL8LWtXVenlS1kmAvNFxyDL1YheTy+77lCU1COL2GEKYoh9U/YoaOgeiBdwy0JLiQBQc63ictIiOXE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=W04Ii0io; arc=none smtp.client-ip=209.85.208.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f182.google.com with SMTP id 38308e7fff4ca-38e9653b580so118036141fa.2
        for <netdev@vger.kernel.org>; Mon, 27 Apr 2026 12:43:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777319025; x=1777923825; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vnKbSNDgIZcO0kazMykgvUSVqvxbhcx6hIO6cZb+QgA=;
        b=W04Ii0iogymZvJ9NdQ6rPjVTLNXSWlFupZtoJhk+xF46bhFqmsvVFPihJuj+ss5E71
         Eo7Rje1WE+fQO/PDfkvNDN/AR0T8T+u/mkd3yl/mWvIaE3zcgV5dT1V4IRPl+jbzKXlT
         eB+BYRL4PB2kajsDyy5B+8vErIAqrT57SHHgytylvinPTN2gBcu28MbkeUWQo8kzEIXV
         WZXVw1fKcIWGNG1k/1XwrkfZQHgmwO/SBHKUrCXJMxIfrhcKvu4kBUOLt20VWb9MEafV
         /ViFNqdC2wodxBy/jSrtspSTyN2br3P8rl+cH5VEe6ElifgY8fgLwTkPktLqSk/vBR6i
         bigg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777319025; x=1777923825;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=vnKbSNDgIZcO0kazMykgvUSVqvxbhcx6hIO6cZb+QgA=;
        b=pvfUv43vFfizil0D5xrgcfRJ2sjYD/V0vbQ5KefGevInh8maQm3NrWmM786RLEqRiI
         VntO+erXuXPPRDLytiBlpgTUQKHm97532KSyRpo9FEFqX1T4syFJgHyzAXskL0y7z3WF
         TKgTHDsRXVrC/e29h4cZKpjvBBzpev+9hEdFfNq0F4UUwth67MN5GZ3GMn0ZMFhpi/P9
         xOBouOTi0zeL0HT/oHWAIOMVRlajCwQd3xtnuEGsopaSFY31smzgJDuhXv4ygFz1TBXw
         x0AKPYVteMse5BMHjwfL/7uD3gM6Au8iZd5dARW38RuqA2N72R3stjc96lMnvoDJnKDW
         rbyQ==
X-Forwarded-Encrypted: i=1; AFNElJ+V4SQpIhz7r2bJcBbL8DeVfUS1BG301/FqqWMEKqtXSdDWVmzodl5Qakn6JRUM/7jNcnQdYMc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy5FjU23S9c55zaqIgcVvQ9owxXUEzcI1h7OMJfzqAqGlb1pSgh
	2yQF8rmS8A9M2FaZwPA5qe5st0nIEfG5/9ty3chQsYfaAMkz+OTUfPgd
X-Gm-Gg: AeBDietWra7RYNYfLu0+kjNV0HrOmjd8Mc8XasgsmebLVlyi19LJxvuUylWIqty6G4Q
	U0yacZbVqd9b9hoc+5NgUQKafkr1G1jboTlNK8zBiwSRCYIaeWcJen6n6LTrW/vvAiaUAMUKn4d
	OjZsR/dxkN75CTa7xlgGl1vDVUcxllfviE8N84Zc8yRX6vmSWtzvUcp6t0IF+eNqtK7bzjdJHFo
	RbaOrmLWBgiwcLlisSsGTkOFEJvOKjfobCaqIiafpKwk+K1CT3FuHsHEo/lD+3v7ql0GXydhEXN
	jfdIXK3f9nT0sYWDgJSUpZJW02aI9dNsqJu7+5IIIN9ZHLORwTQxjbBc3jgpdgAzzq9rlds38NZ
	7RwuuGSbdmjVZBBho7TdhEed5y1DukQ5SALIsqTEcS/E66QCikbykKQBt30nhfEhG2FsxKe8SUu
	Kf2gvwJNvDiIlQPQBZe0wq35rE4t4i6P0L
X-Received: by 2002:a05:6512:3f26:b0:5a2:a97a:4b5d with SMTP id 2adb3069b0e04-5a746624a24mr69880e87.35.1777319025024;
        Mon, 27 Apr 2026 12:43:45 -0700 (PDT)
Received: from localhost ([188.225.109.225])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5a746407918sm33942e87.64.2026.04.27.12.43.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 27 Apr 2026 12:43:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 27 Apr 2026 22:50:18 +0300
Message-Id: <DI475H6XKCAK.21W6G2ZL8E1BQ@gmail.com>
Cc: <linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>
Subject: Re: [PATCH 0/2] mfd: rsmu_spi: fixes and new IC support
From: "Matthew Bystrin" <dev.mbstr@gmail.com>
To: "Matthew Bystrin" <dev.mbstr@gmail.com>, "Lee Jones" <lee@kernel.org>,
 "Richard Cochran" <richardcochran@gmail.com>, "Min Li"
 <min.li.xe@renesas.com>
References: <20260421090710.395591-1-dev.mbstr@gmail.com>
In-Reply-To: <20260421090710.395591-1-dev.mbstr@gmail.com>
X-Rspamd-Queue-Id: AF85D479747
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	MV_CASE(0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-281465-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,kernel.org,renesas.com];
	FREEMAIL_FROM(0.00)[gmail.com];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	MID_RHS_MATCH_FROM(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[devmbstr@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_FIVE(0.00)[6];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]

Hi!

On the weekends I founded out that rsmu_i2c have the same issue. I'll
send v2 series with i2c fixes inlcuded.

--=20
Best regards
Matthew

