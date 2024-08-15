Return-Path: <netdev+bounces-118943-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D674595398A
	for <lists+netdev@lfdr.de>; Thu, 15 Aug 2024 19:59:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 66C5CB2345A
	for <lists+netdev@lfdr.de>; Thu, 15 Aug 2024 17:59:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BFDC45948;
	Thu, 15 Aug 2024 17:59:03 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE74942052;
	Thu, 15 Aug 2024 17:59:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723744743; cv=none; b=bz0unDLqwDqqDjsVwyOF9bLqctnXY6oJfe6xuMb4+ZI9dt0cqYP5RgOWOQKLE0sOORvmNcjH0TpLF125a9LGnuCCPdxG/QMLTbijziXrDnc2zd3bTk6Fl/F+Q3ujeMufYEywtEI/Wy30WD6vnbkMHTyXJ48TAWcf/WBcKSCJL8E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723744743; c=relaxed/simple;
	bh=fQ4AAJG4BSd9TNl+EJmJOnpZC51wkNn6C4m9s6nlLmg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=czYg/tY1+2G8zRT6HXoQ4+9Ld0Oqh9Cy+hveHxg7jw5miQS+AUPF2grdAEtIeXx966J5cx4tPkAz1QUIOso/gn0Stf9Cvx6YazrIvdW7/bEOWca6x7ipQ+gLRi3tq1PvqkfmgJ8PHunt1dY62AJL6+Lkb1rz3A4Z96N+aXglQaU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-a7abe5aa9d5so137711666b.1;
        Thu, 15 Aug 2024 10:59:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723744740; x=1724349540;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=o5v2Q6l1w9ceaNBZ9C7Ww9tq5niKQlAAp7GHeeOVfzs=;
        b=H5McBQn+Du1xkPL+qwwNr9LVXhIF898JpM9rGKUBPOtrQZcNWOfeEKDqctxomUZb9C
         wpb94XZdcHJccRAZQYrMkEN227XzIeFgf5hZlRPK/CQRlr7C6JDAnkNKAKSGGKrU6P4M
         FzkcprZ3tfQcCnD9ldjimVvoiWgxRODqLTl4ctpiCztjtSCgtuwKejSWCafIgV0oAlh6
         mWuatUWFpaoxWuB7VTPcaZxGOncBfrnINWxaH42k0nlkwAqlgj85gukJy+c+1AwMUwjC
         0pvlPZK2s7u1vL3m/5WRe1/koQAhdIf92JvkY6WSDgmD/aTKnj2QcoP2BO+l3xHaU6pI
         0EdQ==
X-Forwarded-Encrypted: i=1; AJvYcCWSruij+IcHRc6RhZWVIA0mXbwGeKyhPiEpp1AiCxFlmNBeAe5ggPuk0vQbvPLzCZQlQnCE7oZMJ9EHGaUsSWHlNfYVE6O1r5eko77zI+uG1JW9FmL/fJ3B6IcEyQ7fdj7HSJHUkbfc
X-Gm-Message-State: AOJu0Yz43rwF9jGwznuFp76aupLvtBJTZXd8z4kBMSBXyfqgN2RQyysh
	mQwmdXZVVpIcYWFFwpV5DHoQWCrg6wXEICjKIz5eXHF5zQhz4xXL
X-Google-Smtp-Source: AGHT+IHDdsZ94pqXZzTEOXb8Kz+Rc68GU4+qHoX4pcD9ye0cQO05oMGHUHtiB8RC0IsKR3Nvt/Cxog==
X-Received: by 2002:a17:907:e60f:b0:a7d:3c46:f4ae with SMTP id a640c23a62f3a-a83929d37acmr26046366b.55.1723744739732;
        Thu, 15 Aug 2024 10:58:59 -0700 (PDT)
Received: from gmail.com (fwdproxy-lla-006.fbsv.net. [2a03:2880:30ff:6::face:b00c])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a838393564csm132311166b.128.2024.08.15.10.58.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Aug 2024 10:58:59 -0700 (PDT)
Date: Thu, 15 Aug 2024 10:58:56 -0700
From: Breno Leitao <leitao@debian.org>
To: Justin Stitt <justinstitt@google.com>
Cc: kees@kernel.org, elver@google.com, andreyknvl@gmail.com,
	ryabinin.a.a@gmail.com, kasan-dev@googlegroups.com,
	linux-hardening@vger.kernel.org, axboe@kernel.dk,
	asml.silence@gmail.com, netdev@vger.kernel.org
Subject: Re: UBSAN: annotation to skip sanitization in variable that will wrap
Message-ID: <Zr5B4Du+GTUVTFV9@gmail.com>
References: <Zrzk8hilADAj+QTg@gmail.com>
 <CAFhGd8oowe7TwS88SU1ETJ1qvBP++MOL1iz3GrqNs+CDUhKbzg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFhGd8oowe7TwS88SU1ETJ1qvBP++MOL1iz3GrqNs+CDUhKbzg@mail.gmail.com>

Hello Justin,

On Wed, Aug 14, 2024 at 02:05:49PM -0700, Justin Stitt wrote:
> > I am seeing some signed-integer-overflow in percpu reference counters.
> 
> it is brave of you to enable this sanitizer :>)

UBSAN has been somehow useful to pick some problems, so, I try to invest
some time understanding what UBSAN, and see how much it can help when
solving "unexpected" and misterious issues, which is something that
challenges me.

> > Is there a way to annotate the code to tell UBSAN that this overflow is
> > expected and it shouldn't be reported?

> Great question.
> 
> 1) There exists some new-ish macros in overflow.h that perform
> wrapping arithmetic without triggering sanitizer splats -- check out
> the wrapping_* suite of macros.

do they work for atomic? I suppose we also need to have them added to
this_cpu_add(), this_cpu_sub() helpers.

> 2) I have a Clang attribute in the works [1] that would enable you to
> annotate expressions or types that are expected to wrap and will
> therefore silence arithmetic overflow/truncation sanitizers. If you
> think this could help make the kernel better then I'd appreciate a +1
> on that PR so it can get some more review from compiler people! Kees
> and I have some other Clang features in the works that will allow for
> better mitigation strategies for intended overflow in the kernel.

Thanks. I've added a +1 there.

