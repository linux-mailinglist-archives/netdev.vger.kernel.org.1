Return-Path: <netdev+bounces-263818-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qEw2Alg1qGm+pQAAu9opvQ
	(envelope-from <netdev+bounces-263818-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 04 Mar 2026 14:36:24 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 60B1E200830
	for <lists+netdev@lfdr.de>; Wed, 04 Mar 2026 14:36:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9DC3D30F3A8D
	for <lists+netdev@lfdr.de>; Wed,  4 Mar 2026 13:30:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7AA82390208;
	Wed,  4 Mar 2026 13:30:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="zAXLFEUQ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-oa1-f51.google.com (mail-oa1-f51.google.com [209.85.160.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05C2437186F
	for <netdev@vger.kernel.org>; Wed,  4 Mar 2026 13:30:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772631058; cv=none; b=MBg3/9xiQAVUovfaBnhp5sNtBqy54EPcVh0DPeF6CQRZNbyjjf8CO8MMR0Ur+ddeJt7/YZl7PD1ClY5PH/mV/84J05PlHYekePCZ6s5/MKQqMcWFQ6twWiL8pgiwi77mchPFewwAGg/GqS0qRdpw6eybyjVsn5/n7kIwU2foPvw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772631058; c=relaxed/simple;
	bh=Mati51LWmyzTXi5oh+i3bfi2MmfG4RbhWeULF7IXsmM=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=JlwInrZ12B4/vyUDHLk2g4GkER0vSM2tg3UIyrI3CQz+mM3iv25MBsvADWEYR2ACzViL6/ZIir2nWUa1/8PY+zhm0Ye4ZFTf7zdGIbzeNG1L7u+gasCFMerUye7pgCthEE5ykd1Fu7FfMo25+TbBD5MKyiCXc29LT+8gEBpcHc8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=zAXLFEUQ; arc=none smtp.client-ip=209.85.160.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-oa1-f51.google.com with SMTP id 586e51a60fabf-4094b31a037so1339247fac.1
        for <netdev@vger.kernel.org>; Wed, 04 Mar 2026 05:30:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1772631055; x=1773235855; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DAg35Q1NUQUcIj+RoSLSwNOktvkzuGN/8zIJVI3g440=;
        b=zAXLFEUQPYDBqL3E8QG9Hx30rqVlRXyU7gxJ67TyENDr3t2H/eCWvxSs8GfMKAotan
         dRUawX5X5JjR1TQdTzc62qSg0Fye1KF98yk+BWz6QwD2wj6RCV5EFrLU5R7j6KzZKc5w
         eDf2SAC7F/+YyjOXnqF98mxYfmWZMnCvuqcAvTRIRJdnv08AQ0jEEFICTxY9idP4iEIK
         +gxAA5fIB8qfTFbmqmX6eyVuZW3TGFaOtP98c5NSkMt0QB1UwWOFi7xPVECzS5UBPTJi
         h6Libu6evq4p6wWpR4DEgipa/6Gsjgf5Gucc8+JFprLoaWiEVnBX57TQkuRQLsbXkz9O
         VDhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772631055; x=1773235855;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=DAg35Q1NUQUcIj+RoSLSwNOktvkzuGN/8zIJVI3g440=;
        b=ufxy7x0uI1kc+FvJxZzj8tjzhes/ZPSP4rduv991FCLi3LA1BG/o7fTgcqUSdASwrz
         fkuObYJiuj1b2qJsv+S5hKtlhYqSygx5Fl84/hHlFtLy6GdY5Kq6TPKzLpsP7nu/cSTw
         Eh8qjymQAt2AvqPgmB2GjlPN2B0tRZ52tvUXEjzgprAPOxNkFso9a/FoBLpDA+hhw+9D
         VWzg5PJJ7tbiYvJNbiiA5gNMJ8Hbf+UFcA8KahqT8/QOEDUTRd6hGAuoKpYamtbSNeJZ
         qW4a2Ex+Oy9vcPiR2G5kuRjgenB7skSMhcdgTjqeMyLlqG74LzPHyOyrdSZdmpj9UsDv
         yt0Q==
X-Gm-Message-State: AOJu0Yypi8hhQPTlQvOM2pKPalOEKbZ/q8Pz2y+dFerJWAGm1fA6TJf1
	lvBq2p8addDsLYofXB6AbnjMff3VFNn2cWnS/qlv2X6t1J578pBKLLgjJmb0hXMX6/A=
X-Gm-Gg: ATEYQzzjgIEmGssW0W5dPyKrF3q5mUxFMY0GJoblWcZoZ3HnMtIl49KN0XqBIyM+UiX
	LJY3SKyuowgGyP+OMPbOm167H0UbqE3vZk3JnFboMV9kQ7IPXkip9JO5hAe31TM9kbLMgxqowmh
	Ox6SXt6bvoV2D/pvIzawwmLx41hW5t8Y79HOht6ot7NOcSj/tk6AUABmF22zFXBlYNP+185Z+VB
	NUmnZRSPevUdXqMtvLJ0L5p7s7EmagA1Sdh0/A4ZSIQDkh78PuO9Isw9kTzZd5lUW6qysJaQCeI
	fmY7iXhHEUWX4y4OFIOg5qCOMkbPjl91qnj0BoKiPJmriJO361NzRSvas6Myf+kICHiQ2A/cIcm
	S5z4/1Gh+/bNgeiTxp5gToO7be9JjyF8Mo+SU9wG9pIte2sh85SiU3ZDQoWTZO2prO1arjdKh44
	ebYmsLR0bvH1I9hIYsUtNFXl8R5G7cyq0OMf/OApCt6yO+VOWzw8nkrD9rPP3g9csXzjMztsHn6
	FNN
X-Received: by 2002:a05:6870:c0c:b0:409:8bfb:c7c4 with SMTP id 586e51a60fabf-416aba7fe82mr1311080fac.31.1772631054797;
        Wed, 04 Mar 2026 05:30:54 -0800 (PST)
Received: from [127.0.0.1] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-4160cf239e0sm18505462fac.1.2026.03.04.05.30.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Mar 2026 05:30:54 -0800 (PST)
From: Jens Axboe <axboe@kernel.dk>
To: io-uring@vger.kernel.org, Pavel Begunkov <asml.silence@gmail.com>
Cc: netdev@vger.kernel.org
In-Reply-To: <e93675f7a196a178d2f389c69ad96079cf98e1bb.1772627580.git.asml.silence@gmail.com>
References: <e93675f7a196a178d2f389c69ad96079cf98e1bb.1772627580.git.asml.silence@gmail.com>
Subject: Re: [PATCH 1/1] io_uring/zcrx: use READ_ONCE with user shared RQEs
Message-Id: <177263105363.30929.8824112170084503703.b4-ty@kernel.dk>
Date: Wed, 04 Mar 2026 06:30:53 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3
X-Rspamd-Queue-Id: 60B1E200830
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_DKIM_ALLOW(-0.20)[kernel-dk.20230601.gappssmtp.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-263818-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	DMARC_NA(0.00)[kernel.dk];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[vger.kernel.org,gmail.com];
	DKIM_TRACE(0.00)[kernel-dk.20230601.gappssmtp.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[axboe@kernel.dk,netdev@vger.kernel.org];
	RCPT_COUNT_THREE(0.00)[3];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Action: no action


On Wed, 04 Mar 2026 12:37:43 +0000, Pavel Begunkov wrote:
> Refill queue entries are shared with the user space, use READ_ONCE when
> reading them.
> 
> 

Applied, thanks!

[1/1] io_uring/zcrx: use READ_ONCE with user shared RQEs
      commit: 531bb98a030cc1073bd7ed9a502c0a3a781e92ee

Best regards,
-- 
Jens Axboe




