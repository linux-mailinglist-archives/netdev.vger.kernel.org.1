Return-Path: <netdev+bounces-110321-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 15D6B92BDF6
	for <lists+netdev@lfdr.de>; Tue,  9 Jul 2024 17:15:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BE5491F23DBA
	for <lists+netdev@lfdr.de>; Tue,  9 Jul 2024 15:15:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C36519D074;
	Tue,  9 Jul 2024 15:15:30 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E431019CCE5;
	Tue,  9 Jul 2024 15:15:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720538130; cv=none; b=Sa3qYkswAr3G56O/G+Mt1X4vTqnrA4KTsSDyxy9YpghHxTrp3xAHzb5vkvCUuflD0QZEz1iNG/67xbMmkeTGAVxwIDFqI1q4fceqvXUK/tmGxWKAg/+trNPY7l9h0cP94YkpPIJcyVhsvdhKUmf9Sqv1hUuFF+5Slqnr1AI2wPQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720538130; c=relaxed/simple;
	bh=NxYiReVyL7Qx3FKsMTdfYtPeRiBpPB4fnwq6SS2LE3g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YZiDEvZSjOF3ltwpYN+y31QhzmH/s3uOxGmMoupxLb9kxK6/mgQp03xQvHoBUlMwnCZW8q8Qqk01Bw/73OOlfGMi202IjHmYqvdZOKBekToOvaySynblcqIe5HSIBeKA9jCHKei4bOFs+KCBwKd3faoQTlmgxWOinaW/cpCIndk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-a77e7420697so406145366b.1;
        Tue, 09 Jul 2024 08:15:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720538127; x=1721142927;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=udOmhMw6nVnLDB7CnXYCG2+/atZ0tO+NBuzOh1Ic4BU=;
        b=u4SsqCstrN1IXnletBUTLCdkrjnj7Kl/kiD5DLEIeVv4XlXmbqfnJrT5RvAh67xPxP
         slSLRZJ+tKAKdhTDD16vHjIIJrHj6WJvByGWq07BZlU/6GuJWIeaxWODnC3H2ciMWah6
         N1P6D9WLC3yIAnlh5MJs46OawQwbbEEquKNu1bp1o/u/csvZafkXf0nTFrlf3rdjzpA+
         H5v5x/f/WlZZ54feyagmCc0ejvQtaz/Hdewer/+hascGXzGIvAoQc5WIRpGc6zcYOOsf
         vZHe3A1ehhdA15bwSL8+aBjJ+ootO5xSey9WJjcH4SZpVYvYOl2yXbWOQDZpeZE51n9O
         8hWQ==
X-Forwarded-Encrypted: i=1; AJvYcCX1LogXDBLbHIZRGTc+gXuqDolZVlhbA/YnGUjkJRNq/ejXDHMWs8QdqKCsGKBj4eb/FwKqs0KSVurnQkjOpnBWR+UBW/Lj3rFGoRcGU31s/J6+CCHmfyUV+5kIiMxMkpLe8E9Q
X-Gm-Message-State: AOJu0YyEVhVWc0B6EcBT+wEp24Tbeyeg5ash5LN6nb11CjRHKXTV/qQM
	DjQ8+i7UThgkriZgITHddaO8cQdsGqfvp3KJN34Mf9F89SlDAk7L
X-Google-Smtp-Source: AGHT+IF35/Mch11jtk1xVIeWdVFdvciZZUw5TTShgdZrcKMKdHljQsWt+u2oBbViFk5ZTk6F/AOa7g==
X-Received: by 2002:a17:906:c083:b0:a6f:49b1:dec5 with SMTP id a640c23a62f3a-a780b705231mr177181466b.46.1720538126122;
        Tue, 09 Jul 2024 08:15:26 -0700 (PDT)
Received: from gmail.com (fwdproxy-lla-001.fbsv.net. [2a03:2880:30ff:1::face:b00c])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a780a853a62sm83568866b.157.2024.07.09.08.15.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jul 2024 08:15:25 -0700 (PDT)
Date: Tue, 9 Jul 2024 08:15:23 -0700
From: Breno Leitao <leitao@debian.org>
To: Vladimir Oltean <olteanv@gmail.com>
Cc: kernel test robot <lkp@intel.com>, linuxppc-dev@lists.ozlabs.org,
	linux-arm-kernel@lists.infradead.org, netdev@vger.kernel.org,
	llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	kuba@kernel.org, horms@kernel.org, Roy.Pledge@nxp.com,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/4] soc: fsl: qbman: FSL_DPAA depends on COMPILE_TEST
Message-ID: <Zo1UC/grXeIocGu5@gmail.com>
References: <20240624162128.1665620-1-leitao@debian.org>
 <202406261920.l5pzM1rj-lkp@intel.com>
 <20240626140623.7ebsspddqwc24ne4@skbuf>
 <Zn2yGBuwiW/BYvQ7@gmail.com>
 <20240708133746.ea62kkeq2inzcos5@skbuf>
 <Zow5FUmOADrqUpM9@gmail.com>
 <20240709135811.c7tqh3ocfumg6ctt@skbuf>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240709135811.c7tqh3ocfumg6ctt@skbuf>

Hello Vladimir,

On Tue, Jul 09, 2024 at 04:58:11PM +0300, Vladimir Oltean wrote:

> On Mon, Jul 08, 2024 at 12:08:05PM -0700, Breno Leitao wrote:
> > I thought about a patch like the following (compile tested only). What
> > do you think?
> 
> To be honest, there are several things I don't really like about this
> patch.
> 
> - I really struggled with applying it in the current format. Could you
>   please post the output of git format-patch in the future?

This is the output of `git format-patch` shifted right by a tab.

> - You addressed dpaa_set_coalesce() but not also dpaa_fq_setup()
> - You misrepresented the patch content by saying you only allocate size
>   for online CPUs in the commit message. But you allocate for all
>   possible CPUs.
> - You only kfree(needs_revert) in the error (revert_values) case, but
>   not in the normal (return 0) case.
> - The netdev coding style is to sort the lines with variable
>   declarations in reverse order of line length (they call this "reverse
>   Christmas tree"). Your patch broke that order.
> - You should use kcalloc() instead of kmalloc_array() + memset()
> 
> I have prepared and tested the attached alternative patch on a board and
> I am preparing to submit it myself, if you don't have any objection.

Sure, not a problem. You just asked how that would be possible, and I
decided to craft patch to show what I had in mind. I am glad we have a
way moving forward.

Thanks for solving it.

