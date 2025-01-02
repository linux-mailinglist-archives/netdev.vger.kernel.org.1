Return-Path: <netdev+bounces-154700-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C92239FF7DE
	for <lists+netdev@lfdr.de>; Thu,  2 Jan 2025 11:15:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C60A33A1670
	for <lists+netdev@lfdr.de>; Thu,  2 Jan 2025 10:15:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4EA751A8F9B;
	Thu,  2 Jan 2025 10:15:44 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E311D1AB52F;
	Thu,  2 Jan 2025 10:15:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735812944; cv=none; b=di9pybHnAgDyLinnM++8tcye+u1oxsFAnLbo20Nd7OS9uoyJjs8cHLtRWMUxLgL/UBaWWQ36UorVg5Zme6WZchANWr+gYVBJZx7xY9izJA10LfKOcK5OHhd+SwmAScuLpYnhpVUlYx0HXq1XmrvY+ayCDCkfzxaIYg2pClNkqPI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735812944; c=relaxed/simple;
	bh=IqD1rYgJ3ch66LuKzrsna8MYtfPYqytfe3biHukTTjs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OPQAVGJgX9A2wVvwBLTD8ssL6WVFR7Wcmy1d08fVo+Gyt+fq4CvBUCraa5kCiEaKVQs5LthJz6Yd2QAv/DZm98ZRDfrNguTmckha19cIQx/DNSeNep9z4EQ2kseZgcGvpVz46Z1/IsFOel9RxZh+0r2VEfnePmQS+vtLs7HmOI0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-aaeec07b705so1046853566b.2;
        Thu, 02 Jan 2025 02:15:41 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1735812940; x=1736417740;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sg5x3HXKSUeq0O4d13HngJWLVCRPQW+x685IF1QbjE8=;
        b=L70pFhBctZT7ZnfoQEzMdIorQ9pQy1Srhk6KgAa4cKT4pnHWO8FEYD2SoqLq+gYoHL
         lt1Awerf7QeNqJ9pet76S5TIpbMYLU0BH+FoTs09crW+coUCJnGpss1P5L29FQS14s2o
         yh50EZoWeqFVUbJTiZxDStoDTz3xj83oqa1dCjy50xymM7oUVQGO22aGoJbDlwiNpK2c
         dCoVQpdYzCobwzSJSxrmj+Bqq324vxfLqmNmgfcFkSwIskAddS1gaQalcPbw/79vAq7Q
         +f8DVrWUyYw7dF/XqkUhyHaNdp00AtSp7Viz72mxFuWMLpw69LbaBfK2+aZzb0khvnqn
         vccg==
X-Forwarded-Encrypted: i=1; AJvYcCURZ728PIJcxZQG+8K6o/Uq1RyEDkPEixZFmz2YL+CpPFniy+eLmH+eGbbk11PNyhcMp7GR3G+D@vger.kernel.org, AJvYcCVqSGqOyCTrKYjTn7vqyzTcZZO+8XIVCiFZi9qlyyC/pWPTA84heQO3sMruN7HYIKN245D8NMe2L0Vtx8A=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw7ouyErKTRWiSff3Powu3KwoVupByrunr2SET2QKK0ApYAJZrw
	4MIBekkJn3oMxsQpU5Bhrv3I7IbnRt0OckcFE1ffRXDfv2RGCk+h
X-Gm-Gg: ASbGnctg5hurCXZ754Fs5ZZuTmCjHETLQc/Gv2VEQ4FlUVgJ8eulUW02n2TncqlUc+Q
	VIjlwo6NkM9/Okfady1Neu3yZWAC5/pQfaCQsllI0a/7OaZ7njx5nNJzm+fvNaBpkYO/GNSR9Kq
	0h3aalJoaO0XXfEKHkFiYwn5R3ApC5ieRsLYWAkRY4GKDVdtWdc1hvrIxNOMgE8qGky4Ks3Irfy
	SEC6U8jtlrLfnHi9YAdW2Sh2jZ3nytHVsoS2W2jSA5c41Q=
X-Google-Smtp-Source: AGHT+IGrcMZgPYpxhNzW3fJtDo4W6awVXN3qOJhoZQMhpuKeyZFtdRrgep7r2aPICudw8LGsR/r5hg==
X-Received: by 2002:a17:907:96a1:b0:aa6:7cf3:c6ef with SMTP id a640c23a62f3a-aac2ad88f9fmr4729536566b.15.1735812939648;
        Thu, 02 Jan 2025 02:15:39 -0800 (PST)
Received: from gmail.com ([2a03:2880:30ff:4::])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aac0e895372sm1757453866b.58.2025.01.02.02.15.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Jan 2025 02:15:39 -0800 (PST)
Date: Thu, 2 Jan 2025 02:15:33 -0800
From: Breno Leitao <leitao@debian.org>
To: Herbert Xu <herbert@gondor.apana.org.au>
Cc: Andrew Morton <akpm@linux-foundation.org>, Thomas Graf <tgraf@suug.ch>,
	Tejun Heo <tj@kernel.org>, Hao Luo <haoluo@google.com>,
	Josh Don <joshdon@google.com>, Barret Rhoden <brho@google.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] rhashtable: Fix potential deadlock by moving
 schedule_work outside lock
Message-ID: <20250102-daffy-vanilla-boar-6e1a61@leitao>
References: <20241128-scx_lockdep-v1-1-2315b813b36b@debian.org>
 <Z1rYGzEpMub4Fp6i@gondor.apana.org.au>
 <Z2aFL3dNLYOcmzH3@gondor.apana.org.au>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z2aFL3dNLYOcmzH3@gondor.apana.org.au>

On Sat, Dec 21, 2024 at 05:06:55PM +0800, Herbert Xu wrote:
> On Thu, Dec 12, 2024 at 08:33:31PM +0800, Herbert Xu wrote:
> >
> > The growth check should stay with the atomic_inc.  Something like
> > this should work:
> 
> OK I've applied your patch with the atomic_inc move.

Sorry, I was on vacation, and I am back now. Let me know if you need
anything further.

Thanks for fixing it,
--breno

