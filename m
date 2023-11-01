Return-Path: <netdev+bounces-45551-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B6B97DE166
	for <lists+netdev@lfdr.de>; Wed,  1 Nov 2023 14:18:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E61DDB20D2C
	for <lists+netdev@lfdr.de>; Wed,  1 Nov 2023 13:18:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4B1612E46;
	Wed,  1 Nov 2023 13:18:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="N818wfn+"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5484411CB7
	for <netdev@vger.kernel.org>; Wed,  1 Nov 2023 13:18:04 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 182D8FD
	for <netdev@vger.kernel.org>; Wed,  1 Nov 2023 06:18:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1698844682;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=s06ZDF7kdX12UrkeieLeIAq7cjcFY81tTAswnpTaseg=;
	b=N818wfn+1dRUWsZJ0xScwr0xOJ9faxII8bI72sJc0Fe6xU2/iihtmIRpoqNov/lcy+TYZM
	XbwasjuXNv62c6fZb17O8zxwQ6jKWCBVL03vYvdGIp9KYCIvDNpCJlrVmqjxs9eS50GK2L
	0kY28bk7cxeDk4NGgIK3HxXYFRoX+QI=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-341-HVwB5c0oNDCQcUQ9NkURkw-1; Wed, 01 Nov 2023 09:18:00 -0400
X-MC-Unique: HVwB5c0oNDCQcUQ9NkURkw-1
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-778a32da939so752886685a.0
        for <netdev@vger.kernel.org>; Wed, 01 Nov 2023 06:18:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698844680; x=1699449480;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=s06ZDF7kdX12UrkeieLeIAq7cjcFY81tTAswnpTaseg=;
        b=lOIXR5Y3mMZQofxvSHgYngygoDo8E73xrrg/2+sPHJYjt/uEIKF8PUF74iKGNtsmL6
         3QXDc30bIDUdiX7KvDtqrNe4hkANcgPAnTuBqcvt6vp8WBwfgQzOkNeF+EU8Hx1XvVpz
         VSn3ADwgEG6l1XPCctUklLRNznXkPp5QkxECaXdAyFgWhfuWGHzTlXJZCHEW9kZyG6ir
         dF1PqAtnZFfrbjfYo8CkcPtdZ4CFdQr2MUjahsUxuOQ8W56/pAbU3mgqTW0kUqSG6MQy
         bhgh4Pf87MAr5jkYfn5AwWUzXj7pyQYFEDlkJ2wJeqNJHf5CaKNdqhxX8Ofdtnky4pzY
         U4Dg==
X-Gm-Message-State: AOJu0YwOk6/nGFSRWwmKlztdchsafgxPtAUE97+ec5cuPJ+mpKXxJJtf
	Wl1NqIB1pCtrf7/Y7uhSLDiZQRHX/uGOMN3xcIe8t5isIOyTSbWOF3qiyADqpMoCD284M6tN3lx
	rVV+JA4qlbgsAQO0G
X-Received: by 2002:a05:620a:f10:b0:77a:50a0:6ed6 with SMTP id v16-20020a05620a0f1000b0077a50a06ed6mr1789466qkl.53.1698844679798;
        Wed, 01 Nov 2023 06:17:59 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHSN4rAJxOYDw11HsIVNkPvlGoyLL/vMzzNEBsNspNkZyo/UkchV2Z7kOFZ4xPRqUii4aQK4w==
X-Received: by 2002:a05:620a:f10:b0:77a:50a0:6ed6 with SMTP id v16-20020a05620a0f1000b0077a50a06ed6mr1789453qkl.53.1698844679505;
        Wed, 01 Nov 2023 06:17:59 -0700 (PDT)
Received: from fedora ([142.181.225.135])
        by smtp.gmail.com with ESMTPSA id m11-20020ae9e70b000000b007671b599cf5sm1408271qka.40.2023.11.01.06.17.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Nov 2023 06:17:59 -0700 (PDT)
Date: Wed, 1 Nov 2023 09:17:57 -0400
From: Lucas Karpinski <lkarpins@redhat.com>
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org, 
	pabeni@redhat.com, shuah@kernel.org, netdev@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] selftests/net: synchronize udpgso_bench rx and tx
Message-ID: <wagl7nc7pkhii3x4sfsrklghijumaitniwxxgplh7rqp3ddhfn@7l4syj422xcy>
References: <6ceki76bcv7qz6de5rxc26ot6aezdmeoz2g4ubtve7qwozmyyw@zibbg64wsdjp>
 <65416d9fc1024_bcdbc29418@willemb.c.googlers.com.notmuch>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <65416d9fc1024_bcdbc29418@willemb.c.googlers.com.notmuch>
User-Agent: NeoMutt/20231006

On Tue, Oct 31, 2023 at 05:11:59PM -0400, Willem de Bruijn wrote:
> 
> The patch subject mentions UDP GSO, but the patch fixes the udpgro
> scripts.
>
> There are separate udpgso testcases. So you probably want to s/gso/gro.
> 
The patch synchronizes the connection between the two binaries;
udpgso_bench_rx and udpgso_bench_tx, which are launched by the udpgro
tests. I can remove their names and just specify "synchronize udpgro
tests' tx and rx connection." 
> 
> 
> Might a grep be shorter and more readable?
> 
Noted, will change it.

Lucas


