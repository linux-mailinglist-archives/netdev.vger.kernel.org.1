Return-Path: <netdev+bounces-125834-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FDF896EE2C
	for <lists+netdev@lfdr.de>; Fri,  6 Sep 2024 10:33:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BA8C11C23726
	for <lists+netdev@lfdr.de>; Fri,  6 Sep 2024 08:33:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D60414B945;
	Fri,  6 Sep 2024 08:33:38 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D92EA45BE3;
	Fri,  6 Sep 2024 08:33:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725611618; cv=none; b=XZtKpIA5McfJxag4KNl1BFiPOpxfcflkreHamK0AaP4udu+MW9vbZtcRWAUSO2RmqwA44WQicPH87RsggQ/luBoQt4IF+DHGWba92ssN8EXdbTE3RqnldexVgpgE7W88yhl7eZu63SDGNACIsJT6e5/bRY8s7pIGLZ4DzYwujcM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725611618; c=relaxed/simple;
	bh=cpiiP/a8WYagaZ5Xik48GIkl1auYNZ+kgnNZrgUnfwo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rg2DxDuLEpagW/pdCbbXmYWvwq6LyFxYfj/y42sxYD6DudA1jj6ZEffNjDZ1wKuqcnaRfU7KZASz9IZSjjz54fkI+C1koWAkFP5g0La4vF10F1+7m+kCSQ8JvWRKCS1vmzllUf6BHyl9/nuG1WrLercbGxB3ApcGbKz4G0gmcaA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-5c26815e174so1917480a12.0;
        Fri, 06 Sep 2024 01:33:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725611615; x=1726216415;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oDUzfZByll+vRnVYBIgUXxP9h/bQhb38hRxpuRtAknE=;
        b=wEEjWOk5lom5pN2i6U3togs4MtjUglmLKFPLrS1QdWMKNtbe1IXz7qB6zxpBl7dY3j
         DoOf0KpG6+owGs++cTf6KdyKSI9U24fhkFXhsJ3NBfgCKJ97qCSQ/icN6IgcebDYVPKj
         RAsZ5IVnI9HeHbOQTFzSAGm7+Nfa/6pp2ivf74R9Mt+DrJ6scatbr9cOzorDNc4mE4BB
         gjuom3pQbgnYbEhKqgzGJD38lvMdjEzTnhvJBFGVTK3vFCecDKOCVBMOuOTNXDSxUbSq
         Cz1T1iNF2MoPHdBsmbaOU+dMKZMLb4KvgY0F/3K/SIiiphaFborXVtDn5bhbXpabxrpF
         I07A==
X-Forwarded-Encrypted: i=1; AJvYcCURU20r5wAslMPA1eZTacb5mySRsJMEZDtr6lDba3T2O0jZ60wjSVr0djNVNzR6DxuiBtbBOWiu@vger.kernel.org, AJvYcCXR55S+jOPIqh5NcuPdhrJvP+/pimtNUt8cuXHzIcut7qIRFRklAegPnR/RqJhEyY4HAChM1yvGeh9z7rU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwjBAMVw5FPwdRiCoj3Uugmn1gAUF8IE4Oyo1hA8lwsDhpImzU6
	RUe0a/e9HywJwLXSJmeq2uuKVzMMDSIeBg++oxWr4K77Bbdb56Bf
X-Google-Smtp-Source: AGHT+IFrtcbjg6efbNfcdOcAqRd8vCbzLMgRIkSQlU7LMsaRGRthrG3Zoa++0enR4NK56pJllMwIqA==
X-Received: by 2002:a05:6402:3496:b0:5bf:279:ca09 with SMTP id 4fb4d7f45d1cf-5c21ed52c58mr19116084a12.17.1725611614182;
        Fri, 06 Sep 2024 01:33:34 -0700 (PDT)
Received: from gmail.com (fwdproxy-lla-116.fbsv.net. [2a03:2880:30ff:74::face:b00c])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5c3cc697fedsm2139508a12.64.2024.09.06.01.33.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Sep 2024 01:33:33 -0700 (PDT)
Date: Fri, 6 Sep 2024 01:33:31 -0700
From: Breno Leitao <leitao@debian.org>
To: Simon Horman <horms@kernel.org>
Cc: kuba@kernel.org, davem@davemloft.net, edumazet@google.com,
	pabeni@redhat.com, thepacketgeek@gmail.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, davej@codemonkey.org.uk,
	thevlad@meta.com, max@kutsevol.com
Subject: Re: [PATCH net-next 3/9] net: netconsole: separate fragmented
 message handling in send_ext_msg
Message-ID: <20240906-organic-prompt-jaguarundi-c37ffd@devvm32600>
References: <20240903140757.2802765-1-leitao@debian.org>
 <20240903140757.2802765-4-leitao@debian.org>
 <20240904105920.GQ4792@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240904105920.GQ4792@kernel.org>

On Wed, Sep 04, 2024 at 11:59:20AM +0100, Simon Horman wrote:
> On Tue, Sep 03, 2024 at 07:07:46AM -0700, Breno Leitao wrote:
> > Following the previous change, where the non-fragmented case was moved
> > to its own function, this update introduces a new function called
> > send_msg_fragmented to specifically manage scenarios where message
> > fragmentation is required.
> > 
> > Signed-off-by: Breno Leitao <leitao@debian.org>
> 
> Due to tooling the diff below seems to more verbose than the change
> warrants. Perhaps some diff flags would alleviate this, but anyone viewing
> the patch using git with default flags, would see what is below anyway.
> 
> So I wonder if you could consider moving send_msg_fragmented()
> to above send_msg_no_fragmentation(). Locally this lead to an entirely
> more reasonable diff to review.

I agree. Let me move the functions around aiming to generate an
easy-to-review diff.

Thanks for the feedback.

