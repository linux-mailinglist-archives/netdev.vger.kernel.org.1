Return-Path: <netdev+bounces-270872-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ELmAM/sgwmnHZgQAu9opvQ
	(envelope-from <netdev+bounces-270872-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 24 Mar 2026 06:28:27 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F8813023DF
	for <lists+netdev@lfdr.de>; Tue, 24 Mar 2026 06:28:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C89773037473
	for <lists+netdev@lfdr.de>; Tue, 24 Mar 2026 05:28:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F37E72E0901;
	Tue, 24 Mar 2026 05:27:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oDz0jr45"
X-Original-To: netdev@vger.kernel.org
Received: from mail-dl1-f42.google.com (mail-dl1-f42.google.com [74.125.82.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C783F42AA6
	for <netdev@vger.kernel.org>; Tue, 24 Mar 2026 05:27:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774330079; cv=pass; b=ID1r8P2P0zZfzaSHu2OE6fTfXtEVutFZBP/PF3JXZ/bU1m3prr/YnXwJnb+iCt6WA1M8FYRV/I9HfLF1pgmcBGKJrxItw/gUCt+isAhIIlhJUAOvSkpG0bWRvxzJLiJ4ZnFdNCMMzJmtWuLfmAvBPP0kLmzyyyFZj2/cl1vD6lA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774330079; c=relaxed/simple;
	bh=RNjbcd2eV8/Fk8qF+ylPyEnsEtnpckM6nrd+K19etO0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mpB1bUl3Z/S6E0aAPOtPTuxxg+nUyDUIelNW05YfnjSOx0nGb7QojwfHJj/n2q2VPZxZu2KhxpMS1m3qGSq0UsimHjSoapA4KH+5yALNQDnqZ+snbLSGL+bgnbCbaCrY1P5YBBgyYHBwkGNdpdDfMl6fX0rFUwB6JXpxLJBPy6w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=oDz0jr45; arc=pass smtp.client-ip=74.125.82.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dl1-f42.google.com with SMTP id a92af1059eb24-12a74039dc6so744694c88.0
        for <netdev@vger.kernel.org>; Mon, 23 Mar 2026 22:27:58 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774330078; cv=none;
        d=google.com; s=arc-20240605;
        b=JB95sc5bUeGb8o7mDGPRxIowMihOUTUEGEO0MLmyPDc9dCUEqWEkq60DuqjgkrP7Gc
         51CZimtdV6mFfIAw9IIaTBx/8soRB9Q/dDcIl2xAJ58p440AGur3utffNoOnK7X92kXm
         Sw0QsjhTpKEuEBXTi9P87NlfpQU1fd9O683LHHZ6rMlGa4k2io7DgPVtaIzA+lpGNez4
         4CqA8CVe3sBZh5+zRs+FtctohW6r+Zj4R285KHgMvCJXu8pxPCyFJ/9FVj8T+GoU3l/o
         BNe3Jy+Ppe82M0z0HxorNpB57Of5ZlGvxDUYsD1lcLm6lkNRe53Ywc2Kk0cZjTpP8W9B
         KcNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=RNjbcd2eV8/Fk8qF+ylPyEnsEtnpckM6nrd+K19etO0=;
        fh=IkQ6CVtaL/7aESb/2yeFOjnDNxNKsDakGPl8vFNk1kg=;
        b=OPGJZAyz5LzF1NPilUNrc53gABQHYY5ebvCjzH23jWU6jXuCZnab1U0G0swgny6QTH
         K2DoZKNVaZXRkiqRq31NQ0K+Ge6h4ide1+F+pNJNYsNTRGch8Q53D5JZjGSmR/0fq3ac
         TZNAifsc1p4aK4rkO+Q1H4WVBCTS1EbKDWhwYg0sSknnKeAi2mfyOejMbJ3gxUq5jMmn
         9pH5h6uqUTBJDSq99OJeInf3Caue4K5libFbQVpFaBtku70yluj8SbyDm9vBKH475Rm6
         dI1mfdHJEPsGLrHSbl+WRC0Ky2DJ7K03sR2lOpo2xuFfFnEcYLPvIkIOxMFfZemNO4Oj
         Tq2A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774330078; x=1774934878; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=RNjbcd2eV8/Fk8qF+ylPyEnsEtnpckM6nrd+K19etO0=;
        b=oDz0jr45eM5Oyxk4iUgGUrN8DzBZe5vWoYT7d/3kbvsJ24XyH0yGzIuxhqcf/7jltO
         MoLT7C/rBanhRa537/N30B4A+dBLzJ+dijrnaoBSItgTDgB0UV8yFZE1u/2e/Q4cWzU2
         qnSsg2iqh14hY4YvZHj5V+D1sKeg55nrhbUY6QaBzZzSs3pW+kTESLHVWhorMKyrlP9P
         FtykjTP/cy2iD19EDoGruGYQnkZIhAMp09BP4twgc3ccVoUrqqzrl3IJ8hq2zW1UpWLm
         uplWT0YuqUqliWqAxm3gtlGXLQqYI3NMDe7d4WjXvg4idlGL4OrRss965Go+lY/vBwbz
         OBBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774330078; x=1774934878;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RNjbcd2eV8/Fk8qF+ylPyEnsEtnpckM6nrd+K19etO0=;
        b=ZXOm+VJG2/VfaeEig43RPiE/7QciEyafpCnySsrR9GtX8GqlNQbG+wSiP7+gH+ZPu+
         CvLTO4UQfgsypvUo5S31c/3Gtj46HVKulLh9An4YR9I7eOmmpz5v4hqBINpEtbgvgmzK
         m9Q8YcJQRFf5yV3KUo4twZdOsnocJMqxdobfHJU0NhjsXEa+3UyW4NkrWApg2kxjRnBx
         gD1NX8yXNd+hKTJWPbM6B+wJ6EFrDtKsIY5978sqX7hlzJKO5+OFXq6GRsh3wCYI9Zdz
         sULS8eOR7pDSLrdjGbbBIG5H8T4ROAoB91CSkViK0RleA5/7jyQoAW1s/6odZiY7+aV2
         rbag==
X-Gm-Message-State: AOJu0Yxe57PRrF6dURTDssHTwdidRsc6427xE+Tl9pgGUV2qQ8IJUr3U
	AJYIXWAvdQUUYG4HxOCMQccjHR47TOD318Snt4DeFhII4AwuJDpGp5KP98IxLYtp6falr4z1z4c
	Ois71dmmuDeiMAtazLzU23OIsq7Wvx7o=
X-Gm-Gg: ATEYQzxS1yOasxYrixwgvBZr8uLpVJfsmc/Qix7c7iW+f/XjqsNm2Or+fadW+5mJudL
	uG9bvtoO9V5aSexVx7Joz/5ybojdtrI0FOI24IrbNskiTX/QR8GP7s6C0ftwLahYe+bwTh4dXvM
	TPmlhmyS8KP6mETPPGKBZb0ZCX9bhdX8+/PvYJzc6d5sfQ1OtHdIcqd8QquEQVbsaxwlAIBb0U5
	Dzy5YwVgL/GF4ptEJTwr8XWJLW/1fB7sS3u//tnL3xqlb65uUUDyXCy2z7NXmAzlqbtFzCnYTpZ
	RtLnq5S3flfUfdoeCws5Y5JYNqzt/E9lOm0aty2w
X-Received: by 2002:a05:7022:327:b0:128:d494:a1ab with SMTP id
 a92af1059eb24-12a72652be2mr6281945c88.15.1774330077945; Mon, 23 Mar 2026
 22:27:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260317065137.1533226-1-atwellwea@gmail.com> <20260317065137.1533226-4-atwellwea@gmail.com>
 <acAZoCnlITtD7ufM@gandalf.schnuecks.de>
In-Reply-To: <acAZoCnlITtD7ufM@gandalf.schnuecks.de>
From: Wesley Atwell <atwellwea@gmail.com>
Date: Mon, 23 Mar 2026 23:27:48 -0600
X-Gm-Features: AaiRm50Z9iLjwnRJbgwDlL-7pxLJace2gfxIa3Rg-XB7nLCBzCA2DVlascvPydg
Message-ID: <CAN=sVvwBfu1zMipnPmTiejJm=Ai3korkNuxSRLee9DZztZWnRA@mail.gmail.com>
Subject: Re: [PATCH net-next 3/3] selftests: packetdrill: cover scaled rwnd
 quantization slack
To: Simon Baatz <gmbnomis@gmail.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, davem@davemloft.net, dsahern@kernel.org, 
	edumazet@google.com, horms@kernel.org, kuba@kernel.org, kuniyu@google.com, 
	ncardwell@google.com, pabeni@redhat.com, shuah@kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-270872-lists,netdev=lfdr.de];
	FREEMAIL_FROM(0.00)[gmail.com];
	FREEMAIL_TO(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[13];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[atwellwea@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 7F8813023DF
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi,

Thanks for pointing that out, have a V3 coming that should fix all nits.

Thanks,
Wesley Atwell

