Return-Path: <netdev+bounces-182137-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BE7DEA87FEB
	for <lists+netdev@lfdr.de>; Mon, 14 Apr 2025 14:03:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0612E3A7B2F
	for <lists+netdev@lfdr.de>; Mon, 14 Apr 2025 12:03:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08A9129DB8B;
	Mon, 14 Apr 2025 12:03:08 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EB0129CB4E;
	Mon, 14 Apr 2025 12:03:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744632187; cv=none; b=aWMVpfu+5wxme1skIW2NzUbStLpQuPJt5r2XngSa92KNmPDQ4G68KHok+/Nefr5rJJ7YTTYluBvbGYZXsoKF6V73m8fJIhQCU79vzF7WCXVRP6I8SbYTmyo9jPis3shIbGOqzPiHECnj0hQOtpgJkWFLR1TgXhvsxCCrQdOIWaw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744632187; c=relaxed/simple;
	bh=byz0Xi0jCuuOuBx1TCeITGZEdBmUoxRM/PvGpUw9vfg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fAzvqklOg8l/NqjOTlGqd3rbKdb6b+xd8pdYpdueXEHyCkPjBN96cYLzmL2ShX2YFEq3bANn+QLQ6gVFN8zuDulHCeiIlSCeyLjhzht/HWwpGgu0JLugH7AoAkUC2M1ydDSJQE2M9Y8prbC25cbfXn4nJZLhyLc6hCu6SMMStXU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-5e61d91a087so6133384a12.0;
        Mon, 14 Apr 2025 05:03:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744632184; x=1745236984;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=L/F6w/jKotn2gBYtH0XsI2WxseTGW06hCSmGwk9bJso=;
        b=MDEyXdN2BAbAdQmmkBbt2zhuFKqBAsMpiW4yFv11XkM9NGFZdyuDGaq34Mt/MQjgwy
         qswPjRWHEjyH4qh0tHtds0DdTiayYzt0C4ZjCOV194JYGYSPbhyL0tJAk8t6IRFXSNz0
         tdDimVXskwa0ucqrXZa6xtYKfMa8BxflWsWE01Diy4BqlfdSnn4ewKiGz0wtKoiPdcp2
         AsjlmytXDgdVA1CzDMDk1lgiswEZxbeYG377EVGjSU23+4fdFQObuo/QO3cxJVEmJtfr
         NEkgr3h14lz5Q/GcUNAOYciRRaK6gnfPMYrtu5Ls2HwVTnTnPLgSWo2G+bhkTMb0efo5
         sM1Q==
X-Forwarded-Encrypted: i=1; AJvYcCV98o5HoQgvBs2noiiEGP7Ud39+lZxsadeW7yAoyfv9FDkzFPJkfTU1JouJ13gvkB7Lo7CEORZ3@vger.kernel.org, AJvYcCWDoQb7vLr/hyfEGip8z6TsPRrm5Ry+mQ3C0U9SSOsSyu1SHPAMSXsotKB2nED/XmcjfmFu1XrkYxJDBqU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyx7oJ2aL92kQ3/lJ1fpy7gbXlR2p/F6qn3BROykWGqOk6Sl8PN
	1GdmiIrzel3fgWV14xfaGUXmwFrsKjVFgAMn55yvQ7ZerH9dxM8Y
X-Gm-Gg: ASbGnctrlJlt/a+wRqb2Fr0BICgHHFJ1UjfjVDvRxhEr7+Ys/veB2bYBUyH6TA3eIt0
	ONaUzZpjGIIIfhpXMaCz8ZkJ2VZkrEQiJJ/q9mk/93/PdoQvFwc6fV9IgY38b6b+kWFTNRh9fIY
	73svPJ46OCxgKvhPALIEDBBfqyapXoVbQdpUkdwArQJ6bhzhSlKyGKYNZAE14131mUVA2XrrhdN
	h6oahRIW9YjgQ7nMwIRDxndQl5CjA7hR4eFdv/e1EEROJ2I3DQVh5Bloi0sEPkC61C80JENK66h
	SVl2sY+gmZhozZDRiUs1Kk0+74UG
X-Google-Smtp-Source: AGHT+IF3qbKXOEi8k4LkqguutUu++uj40Fsc9bpD9fLF6uF+6eG4gP5qdvuX3YPF/n8oO4K31IOsgA==
X-Received: by 2002:a05:6402:34d4:b0:5ec:9e6e:c48f with SMTP id 4fb4d7f45d1cf-5f370127346mr8172062a12.29.1744632184203;
        Mon, 14 Apr 2025 05:03:04 -0700 (PDT)
Received: from gmail.com ([2a03:2880:30ff::])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5f36f527df0sm4863042a12.71.2025.04.14.05.03.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Apr 2025 05:03:03 -0700 (PDT)
Date: Mon, 14 Apr 2025 05:03:01 -0700
From: Breno Leitao <leitao@debian.org>
To: Kuniyuki Iwashima <kuniyu@amazon.com>
Cc: davem@davemloft.net, dsahern@kernel.org, edumazet@google.com,
	horms@kernel.org, kuba@kernel.org, linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org, pabeni@redhat.com
Subject: Re: [PATCH net-next 9/9] net: fib_rules: Use nlmsg_payload in
 fib_valid_dumprule_req
Message-ID: <Z/z5dTyAdyiBsiit@gmail.com>
References: <20250411-nlmsg-v1-9-ddd4e065cb15@debian.org>
 <20250411213952.69561-1-kuniyu@amazon.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250411213952.69561-1-kuniyu@amazon.com>

On Fri, Apr 11, 2025 at 02:38:01PM -0700, Kuniyuki Iwashima wrote:
> From: Breno Leitao <leitao@debian.org>
> Date: Fri, 11 Apr 2025 10:00:56 -0700
> > Leverage the new nlmsg_payload() helper to avoid checking for message
> > size and then reading the nlmsg data.
> > 
> > Signed-off-by: Breno Leitao <leitao@debian.org>
> 
> Reviewed-by: Kuniyuki Iwashima <kuniyu@amazon.com>
> 
> You can use it for fib_newrule() and fib_delrule() where
> nlmsg_data() is prefetched.

Agree. the code becomes way more readable, and more looks like more
"net" code.

Thanks for the suggestion, I am adding an additional patch for this one.

--breno

