Return-Path: <netdev+bounces-164740-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E1A1A2EE8C
	for <lists+netdev@lfdr.de>; Mon, 10 Feb 2025 14:41:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 165093A9682
	for <lists+netdev@lfdr.de>; Mon, 10 Feb 2025 13:39:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE5D3230995;
	Mon, 10 Feb 2025 13:40:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="hzpluzKj"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 926A722FF5F;
	Mon, 10 Feb 2025 13:40:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739194801; cv=none; b=eTq+txtAfi0v4VoIt1wY+aRaeLfvdf9uv/soMrAVzBk+LUd14/+yRdqX20ZPMG8LqKSS+Vg4XT/ihoZk9MGb4mrUI822tFqVJFA5K+r5gwwbai7pEjMSvj8xp8NQ/GbDe3uYq7hxvAQQvGobvNufk+81UjFompsFnBJY+aOI9HA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739194801; c=relaxed/simple;
	bh=Mw6X/iqFQUdzZzpOTvgXgiCD2YSzyQe6hZv0qS0ER/M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GBr7CYYtC4ESjfjKkjFuxZXeoK6vlsn/XU2oZkvPlw3+gbTcV7Xf7Y8RSFvPc5/MeVf0gQpymc/bKlAjc6+wKG66dn6JJrpu08uZSUjXByb+6zJUydKA1G5E0PxIwm3LYKrGVL2pniVA9+LIa12SYveZGjM6xxTSt3IHt+GIuJM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b=hzpluzKj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 908C3C4CEDF;
	Mon, 10 Feb 2025 13:40:00 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
	dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="hzpluzKj"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
	t=1739194798;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Mw6X/iqFQUdzZzpOTvgXgiCD2YSzyQe6hZv0qS0ER/M=;
	b=hzpluzKjElge+d0BeJ+1lXjJXX/0w/UYWdZVIUVHKQCJhmjmof1H9YRzZlJapVk+uHhsYu
	kM86E4ugo2FYbKRUgqSLzEcYjHVsWtE5sQgSMkWLJelnRLWN+5fCXgv85ktSGPEsNFIcmE
	XSaXVyuOuBvifQLAXJM0G41jvkN+D8U=
Received: 
	by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 213f8e9e (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 10 Feb 2025 13:39:57 +0000 (UTC)
Received: by mail-oa1-f53.google.com with SMTP id 586e51a60fabf-2b86e13e978so898875fac.2;
        Mon, 10 Feb 2025 05:39:57 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXojE30cQrWfUT0v5qU2DfamSB2J7J5Q8FqrccTW8dCAAfFC2zq1RfzNCGEPPnJ1A7yTTfufEI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxTXm1Sg/now8Q/LDe90R+t6QzkNHfUgqwTau9GTyrvPwXb18v8
	lbYkfyCXsRmU+xZ1KudU1AJ1KRwEVmIEPSSvAWSEmm7AWPwsp1NZdn+/Nv3uPX8kE5tyAF1aBV6
	4OcBvqNJMGZfOMuMvBRpBm6PHSjQ=
X-Google-Smtp-Source: AGHT+IFBql/BeQkqRTlpU6s4lc0cE+gDINJWDeeicMaut547jipDtdf44tVSLcmS0dCGOJvnva+WRmdF7y7247OPikM=
X-Received: by 2002:a05:6871:811:b0:296:5928:7a42 with SMTP id
 586e51a60fabf-2b83ecf479bmr8294407fac.22.1739194796660; Mon, 10 Feb 2025
 05:39:56 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250210133556.66431-1-theil.markus@gmail.com>
In-Reply-To: <20250210133556.66431-1-theil.markus@gmail.com>
From: "Jason A. Donenfeld" <Jason@zx2c4.com>
Date: Mon, 10 Feb 2025 14:39:43 +0100
X-Gmail-Original-Message-ID: <CAHmME9oqvWp_Nd1Gwgyw52qy8wxztMyCpNsjByH=VnRaXqczww@mail.gmail.com>
X-Gm-Features: AWEUYZlOFUvKkJGgoFJkHUG4F6JQEQsccvV0zV6xISxrgXh3QIvXkOy6817QqNo
Message-ID: <CAHmME9oqvWp_Nd1Gwgyw52qy8wxztMyCpNsjByH=VnRaXqczww@mail.gmail.com>
Subject: Re: [PATCH] prandom: remove next_pseudo_random32
To: Markus Theil <theil.markus@gmail.com>
Cc: linux-kernel@vger.kernel.org, intel-gfx@lists.freedesktop.org, 
	netdev@vger.kernel.org, tytso@mit.edu
Content-Type: text/plain; charset="UTF-8"

Hey Markus,

Thanks for this. I hadn't realized that next_pseudo_random32() only
had two users left. Excellent.

I'll queue this up in the random tree (unless there are objections
from the maintainers of that test code).

Jason

