Return-Path: <netdev+bounces-260044-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qNWXMN1anGmzEgQAu9opvQ
	(envelope-from <netdev+bounces-260044-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 23 Feb 2026 14:49:17 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4699B17744E
	for <lists+netdev@lfdr.de>; Mon, 23 Feb 2026 14:49:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 862E33077096
	for <lists+netdev@lfdr.de>; Mon, 23 Feb 2026 13:47:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6ACE227B353;
	Mon, 23 Feb 2026 13:47:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="HRswkPtn"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ot1-f45.google.com (mail-ot1-f45.google.com [209.85.210.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D848258EE9
	for <netdev@vger.kernel.org>; Mon, 23 Feb 2026 13:47:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771854443; cv=none; b=mLu6Oh4X6XuVSFJESozxoya3MlvsqMsNq6I3VJt+P52UqjGKqopkeNHS5pF9Q8urku5coOgl08nQJUoO4wFAzgKVL5VyEeC+2AEfMRFKpB66yjRZFOZdB5UbaeSsQSfkn8/Du5G0UUwm+Tsr2SxphsTALog3J2l7ZU45zOc8Jw4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771854443; c=relaxed/simple;
	bh=pEK34LjZoTyAlPG6yprImgqtYWdPVrGi8mwVGjLAUHo=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=clRqJvzosuqHkuYEKPEiUHlO+LgCXaz5w7WVi/lUrzMm8wTAUHlonqXt/rIRogMNYrmG0/dt3CBD1Xqoui5wEpTt8MZKBTCYtZ01QbM/F+NgwX6O2Reuc/5cXdE50rnJ4l51Idxa2se2Kp3f6ExhCKhbgG8IJdBq1SXaZsQbL4M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=HRswkPtn; arc=none smtp.client-ip=209.85.210.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-ot1-f45.google.com with SMTP id 46e09a7af769-7d19bfe1190so3649069a34.1
        for <netdev@vger.kernel.org>; Mon, 23 Feb 2026 05:47:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1771854441; x=1772459241; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=i8Pq+rLSKS6o9o2SEHiwXByvZL8hMyXiox1GLx1oFUg=;
        b=HRswkPtn3eYAWpl9swc4tookL9RbFwUd7gIMVwtLnD6ieSPoDbyz4p1b/+iF1ntozL
         IB0lur1vTZZjIy3lUpqVj8UUUWZf9xfHSUIb6kBLx+RL4eYkqVl+7YXLVyGsyqDIawAY
         wgFN+4Qt5qwN/fKEW4nAqYJgYMy6Ol/zxeRcuw8W40igQt6qxvlhFYmsiGHhDLR0k6ZG
         TgtbSOAgZL6lMn1W39XOJsKFfNBzLYwuoZLZCAM73E25Gms1HJx+5/+sZzW0rAkaRx1V
         MXoJ8lvZE7M2D0LMDUYnXyCRKAaXgu03DNYIBrQD16TGsTDmFMw5klXVVKd+q/6x/4Ms
         uWzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771854441; x=1772459241;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=i8Pq+rLSKS6o9o2SEHiwXByvZL8hMyXiox1GLx1oFUg=;
        b=cxozL52JMW7euq1bzepyfuyGgsOtUpLmxuMa18aXzd4HqI8i/2/dxiS1DA/qSgAhZY
         N8yXxs/iGBOSy1OgALRE3GVzF4sD+gePolFb7Acc5bdQFKafQPxSo8mV7M8p+98WxkFm
         OjWv8PmjB29fgmeBeesoHfkdBKvmKYd/BRWRI766Ujxfl4/LOJfDYdPwp0Q92UOXT/DW
         f55k0Ok+lrIxmJeUTbuIZ2s8G0FK7WuWDfE7l/yYXBvFbxV4A24oBFzAYrk+jionXHeq
         E2eDfP/Yd9wzTw/wZT0JlIWUGlpw4u0wKPz8disB1HxCyRn4jS2WsGiHaDPBUU66SXXb
         s0AQ==
X-Gm-Message-State: AOJu0YwmlX+nVDNPULDvMSgHa6iXRdwqqx/qjyNMEt/bk6Q5hB50OSTX
	pjiiQPCUpz/aoJ+v90cZSkby+c02ZC1hskC52yLNDbYvkAlT6fFZPEBhVyGYLCnvFXmPfmI3U+X
	x9xo0CLw7+Q==
X-Gm-Gg: AZuq6aJZXC8sqi3WS5lPjv+SJdFrU1y41l2OBAK3nJr3QSNwG67FdKPSn96RuzoKhvc
	1aQ7Ng4VA8EN5ortDfLvtOSb6FRLFACPeLc3KY5JsM4aqZSMkcQ7OQnvN7xLo+jhIx2SYasm0Gy
	1d0ySoofQRQwIcOuy0Npln8rwqF8sA/026ebiDcrnbMvR8u4E6Q2cqp5qU+Ql8efbSFGSI2yTZb
	LoCDGmWoAgXGXNvxFkysIfshJ1Cna3Sp1MwLQnupIzmAMvJEulSfHlz60Z6Y3pUEsC2MYtqYxME
	8xZ09L//dxMfa5URFeVIR5kmLDP7eq/AE4Dy77cvRumXaYwbFIBfBtmOf5v2qRNjhoP6rDeE6zB
	5MN+aFfs4u9tP1titTkv9sWLX8xfpnzEZ7cSZfeYhXbxizWP1RSc2VcTRaviLp1Bul1BviU6uuy
	lx/05WRpsjMP2lSZA9HDwIatxOJ6ubi1mB4WslQ+ou4TZuFA+FgDNUmw307KLVieCQxtyqZgTa8
	Yyc
X-Received: by 2002:a05:6830:dc6:b0:7d1:49a9:6b53 with SMTP id 46e09a7af769-7d52bf54550mr6357384a34.33.1771854440859;
        Mon, 23 Feb 2026 05:47:20 -0800 (PST)
Received: from [127.0.0.1] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7d52d04dadesm7246370a34.23.2026.02.23.05.47.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Feb 2026 05:47:20 -0800 (PST)
From: Jens Axboe <axboe@kernel.dk>
To: io-uring@vger.kernel.org, Pavel Begunkov <asml.silence@gmail.com>
Cc: netdev@vger.kernel.org
In-Reply-To: <14826e580830261478a74ed89941694538209bab.1771198073.git.asml.silence@gmail.com>
References: <14826e580830261478a74ed89941694538209bab.1771198073.git.asml.silence@gmail.com>
Subject: Re: [PATCH 1/1] io_uring/zcrx: move zcrx uapi into separate header
Message-Id: <177185443986.636584.5330462186795176078.b4-ty@kernel.dk>
Date: Mon, 23 Feb 2026 06:47:19 -0700
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
	R_DKIM_ALLOW(-0.20)[kernel-dk.20230601.gappssmtp.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-260044-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	DMARC_NA(0.00)[kernel.dk];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[vger.kernel.org,gmail.com];
	DKIM_TRACE(0.00)[kernel-dk.20230601.gappssmtp.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[axboe@kernel.dk,netdev@vger.kernel.org];
	RCPT_COUNT_THREE(0.00)[3];
	NEURAL_HAM(-0.00)[-0.997];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[kernel-dk.20230601.gappssmtp.com:dkim,kernel.dk:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 4699B17744E
X-Rspamd-Action: no action


On Sun, 15 Feb 2026 23:31:20 +0000, Pavel Begunkov wrote:
> Split out zcrx uapi into a separate file. It'll be easier to manage it
> this way, and that reduces the size of a not so small io_uring.h. Since
> there are users that expect that zcrx definitions come with io_uring.h,
> it includes the new file.
> 
> 

Applied, thanks!

[1/1] io_uring/zcrx: move zcrx uapi into separate header
      commit: 0217a2afba9cd21b3833eb93e217f55cad78828a

Best regards,
-- 
Jens Axboe




