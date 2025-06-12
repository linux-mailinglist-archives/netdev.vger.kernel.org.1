Return-Path: <netdev+bounces-197084-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B327FAD77B2
	for <lists+netdev@lfdr.de>; Thu, 12 Jun 2025 18:12:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7CF293B5802
	for <lists+netdev@lfdr.de>; Thu, 12 Jun 2025 16:06:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D0B4298CAE;
	Thu, 12 Jun 2025 16:07:10 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 484032F4317
	for <netdev@vger.kernel.org>; Thu, 12 Jun 2025 16:07:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749744430; cv=none; b=nIZkuAbdJMGRwUDdeozJKv+VY6A5PgNX2vs193J95bnXoSYpU0VZT091Fzql9PluAdnXg3zHq5dlPQ74fRaDjCKnDU9oTHFsIfxOs+99h3gHNotrGgiIgth3JuLpY0Kt6mJVCQRzgzNwlBKJ2fTepeKxABs8B5u4mxcQctdHTNw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749744430; c=relaxed/simple;
	bh=t9l1FLd0SyBz5p7Dj7Utgx+puK73VCTL0xnyDLafmtM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZVW/bHbl+avzs0N39fdXRV9OfPC2O/l7igYBo4718x//A0wsIeK+TstF3vLXh0lQuYcn3S72GwQvnZ/6oeht8AHgXWbMYZ67u3/Tfr0gtGZD29gqtpUTuFaXgweRy/DZ3k4fSzvVC8quzUmUu7mx8iVUCc/oHbEKfjmEusl9KmM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-607b59b447bso2049207a12.1
        for <netdev@vger.kernel.org>; Thu, 12 Jun 2025 09:07:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749744426; x=1750349226;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=W9zcRRMGhecQrFN1xif+WajZ++wlGVTRJSLXv6mySSg=;
        b=qL20wCDZdchDnCC3YwgD5UAc+uBTyKOTiptVCQaHAEjFJCaGeA8sGvUWupjr2txC0Z
         XmxQ1+mzCwMJ1lUsiVjqN1mDOMXWAG99mASNYvMO6eX6AEiz6GjfT0KnjbxVQdwBS2Kh
         zhSFIpxWZa10qMqO7lzspaOOqplJL4oeogN7atPxJRH0+uH5DgPoGHXBFcHLhH9lQEm/
         9XKsRSurJEJcUaeP+vWvVnN+MooIRs2ryNqB0EVYbjB5HqaW9W80ZMRbQRIz8r+io6N7
         Wt+ExtC+ccAOkEjTgOijLRck9wqOz+EEy0MS7XoVTkqYwaNz6LR4O7nwQBzSK0XgpLt5
         HlIQ==
X-Gm-Message-State: AOJu0YwGfKf2ygRp+kZpvRTTkZoFfqFQs/OzIRut3bmKDEgWAcpzVlQJ
	a7O88QWD77Ikt9awioTFvwyCGvFx/ztdJ3/nlqPJE4JjGvBHzrByO5da
X-Gm-Gg: ASbGncvLX8Kot6xRyu3lQt45V+MvxFQj3+KzNDVwHhAVct9dWOYBu6HUqSvVNt1G9ES
	lBC/fRPOFvy4g1H/KpOvxE9aznLn7JfHsE7+iDN0ipT/LHrCaOQdQLHQ+NnyKl1gzbC/RuImzuJ
	t2AQSXCIqd6Pp3RR8ui0AXV+o90pKwXo5NHSVKJB7XoEoglhhDgykNOWlsFzxHPxs2dlDJ8x0V/
	Of7tPOP2iet95BBMb1VgHL3Ld8golV8Ugo/LOtdCG6eL7t7xMU5NrLwBfmn/lhZ6F5UDCjV94BX
	CTXWcLIAf+kNX4Q4q/UifcgoR/mGTA8Qt8k9J5Z8gaW8ECT2Iehq9w==
X-Google-Smtp-Source: AGHT+IE31/Qoh56xEGhONLuZvx8MD+qxMVdxlufU/TawTXUnJPnZrcN/6Rvn517W3e9UHux+HAtg7g==
X-Received: by 2002:a17:906:7310:b0:ad8:96d2:f3e with SMTP id a640c23a62f3a-adec1815e9amr31184566b.22.1749744426207;
        Thu, 12 Jun 2025 09:07:06 -0700 (PDT)
Received: from gmail.com ([2a03:2880:30ff:72::])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-adead4ca957sm158725966b.11.2025.06.12.09.07.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Jun 2025 09:07:05 -0700 (PDT)
Date: Thu, 12 Jun 2025 09:07:03 -0700
From: Breno Leitao <leitao@debian.org>
To: Dave Marquardt <davemarq@linux.ibm.com>
Cc: netdev@vger.kernel.org, kuba@kernel.org
Subject: Re: [PATCH] Fixed typo in netdevsim documentation
Message-ID: <aEr7J0UbSFhJ0Zn9@gmail.com>
References: <20250612153742.11310-1-davemarq@linux.ibm.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250612153742.11310-1-davemarq@linux.ibm.com>

Hello Dave,

On Thu, Jun 12, 2025 at 10:37:42AM -0500, Dave Marquardt wrote:
> Fixed a typographical error in "Rate objects" section
> 
> Signed-off-by: Dave Marquardt <davemarq@linux.ibm.com>

Reviewed-by: Breno Leitao <leitao@debian.org>

Thanks for the patch, it is correct, but, there are a few things that
you probably want to fix and resend.

1) You need to choose the tree you want to send. Usually `net-next` or
   `net`. In you case, I suppose it can go to documentation tree also.

https://docs.kernel.org/process/maintainer-netdev.html#git-trees-and-patch-flow
and
https://docs.kernel.org/process/maintainer-netdev.html#indicating-target-tree

2) If sent to the netdev, you need to have the maintainers in to/cc. The
   tool `b4` helps with that.

