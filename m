Return-Path: <netdev+bounces-138151-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A8BE9AC6AB
	for <lists+netdev@lfdr.de>; Wed, 23 Oct 2024 11:33:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 68DFB1C20E0C
	for <lists+netdev@lfdr.de>; Wed, 23 Oct 2024 09:33:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC87C15CD52;
	Wed, 23 Oct 2024 09:33:29 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E2E514F9ED;
	Wed, 23 Oct 2024 09:33:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729676009; cv=none; b=hwDtf6xWsKGzwxr6CkYvKUxJuD7LieFVjZPwle4+oNXJJzoxUCKpllHTZsba2YMSkwdPObOCOaYkVQ4hZYg9dmqKDoStpDil/RtRKsRoewUWzND8pHmQtN8O+7MX6VZOjU/IE0po3Q2niYYLO8U65poxPw8TbwZEslXx1InmcOw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729676009; c=relaxed/simple;
	bh=bfUBNWwFLKfTBGLkd2zfwZH7CNfkBV8lzbx++T641ek=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NH3kyR9lRiH73uAvf5rrY7rCzb/RyOKtVm0kbMqeWpTg3WoKzoyYpvSIl+HRvCSwoCfN0C9IKuCP9x0MDKTaaaqIl50/Q5aEh21I0q7gZJ4lVPSuha15EaOkEv+AUSuPxbZuMiE4F4NItKZWO6MAFC8wd5pTtmZ1dj22wvP44rM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-5c935d99dc5so7147427a12.1;
        Wed, 23 Oct 2024 02:33:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729676006; x=1730280806;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vn1kct+AaR7zOrbvjx4Kb6wixkI+c0ohNQAwCnY0kSk=;
        b=ZLSS1ZVQMQbxAPRZ3SGVXdQBfvW+n1n4dZCxNy8dO2C9e408oLI7icIBAq42/HvVOq
         EsDiStZ8/BoYcF9fo5Y/XSnPhjJt2fAt7ROl+hdAzBVnAL//QFvGjH4jcGdf6sD+plCN
         TZFVu1DvnrVLgaDVXreDbhIEHIuKAIRSL4yWsubkmGo1yU02jKODjIDr3/C11a3jZqQn
         atYB00+yPsGj+RX8zxBFBzGF6sl7oAs8YQe1Q1yj/Jh/tH2lhoU1Me5A6N7HfXWSKXR1
         njo+xcR7SU/goVqnB/eR6gwvro/KzcWyVSi4bK1nGXKiM8f0LHci7NEYtpnJrNdyyb2f
         359w==
X-Forwarded-Encrypted: i=1; AJvYcCV+OFHf/hHRobs4kWfCzqvQm0Awn9VejeICJIsnMBJdT+9P8z+qDBa2B2FSKaLvEU3l/dTmlUgp@vger.kernel.org, AJvYcCX3Wni0eo4+TTo1Uf/X3TH8o3lvX5ha4TlWkOqzqFeYFWvrV3GHrQ12F04yCcYX9HEq6rVAq7l0QUFm/f08@vger.kernel.org, AJvYcCX6NI5aUBKtErguhe5Zw6klVvdAIv8KidW7xTb3GzilkzT5hdvQ9mp4EePoQJjJzEVbdAN5PmDUQDU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzEDzf3mMHxFDE4S7oA2zC/jg929EromZjn+ggKyy/lEyJf9Okd
	D50CZr5zgWA6MQYfjQ09zr1jmKjmQaUxRkCEGQvMQ2xZJ+SgMv0K
X-Google-Smtp-Source: AGHT+IEkMrop+R2IjYJDv8tG5ep0f9ZEr1Xi6TXRRd2QOzVVwjqUXkY189A9/iiJqxZbCfXfk1S8kQ==
X-Received: by 2002:a05:6402:40d0:b0:5c9:4be9:7c4 with SMTP id 4fb4d7f45d1cf-5cb8b1ac8cdmr1216760a12.31.1729676006198;
        Wed, 23 Oct 2024 02:33:26 -0700 (PDT)
Received: from gmail.com (fwdproxy-lla-113.fbsv.net. [2a03:2880:30ff:71::face:b00c])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5cb66a6547esm4194990a12.37.2024.10.23.02.33.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Oct 2024 02:33:25 -0700 (PDT)
Date: Wed, 23 Oct 2024 02:33:22 -0700
From: Breno Leitao <leitao@debian.org>
To: Akinobu Mita <akinobu.mita@gmail.com>
Cc: Jonathan Corbet <corbet@lwn.net>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Andrew Morton <akpm@linux-foundation.org>, kernel-team@meta.com,
	Pavel Begunkov <asml.silence@gmail.com>,
	Mina Almasry <almasrymina@google.com>,
	Oleksij Rempel <o.rempel@pengutronix.de>,
	Kuniyuki Iwashima <kuniyu@amazon.com>,
	Alexander Lobakin <aleksander.lobakin@intel.com>,
	"open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
	open list <linux-kernel@vger.kernel.org>,
	"open list:NETWORKING [GENERAL]" <netdev@vger.kernel.org>
Subject: Re: [PATCH net-next v3] net: Implement fault injection forcing skb
 reallocation
Message-ID: <20241023-precious-gorgeous-taipan-4e0ad1@leitao>
References: <20241014135015.3506392-1-leitao@debian.org>
 <CAC5umygsk3NyPB99kdKtyV0xdpXihq-VRfzgua_8b40DexQ_QQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAC5umygsk3NyPB99kdKtyV0xdpXihq-VRfzgua_8b40DexQ_QQ@mail.gmail.com>

On Sat, Oct 19, 2024 at 12:28:03AM +0900, Akinobu Mita wrote:
> 2024年10月14日(月) 22:50 Breno Leitao <leitao@debian.org>:
> > +static int __init skb_realloc_setup(char *str)
> > +{
> > +       return setup_fault_attr(&skb_realloc.attr, str);
> > +}
> > +__setup("skb_realloc=", skb_realloc_setup);
> 
> The documentation says "fail_net_force_skb_realloc=" boot option,
> but this code seems to add "skb_realloc=" boot option.
> 
> I don't have a strong opinion about the naming, but I feel like
> it's a bit long.  How about "fail_skb_realloc="?
> 
> The same goes for the debugfs directory name.
> 
> Reviewed-by: Akinobu Mita <akinobu.mita@gmail.com>

Thanks. I will update and spin a new version.

