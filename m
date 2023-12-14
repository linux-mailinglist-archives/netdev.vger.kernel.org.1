Return-Path: <netdev+bounces-57327-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DA74D812E41
	for <lists+netdev@lfdr.de>; Thu, 14 Dec 2023 12:12:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3E4B8281C91
	for <lists+netdev@lfdr.de>; Thu, 14 Dec 2023 11:12:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA80B3FB13;
	Thu, 14 Dec 2023 11:12:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ABNE1//M"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35415CF
	for <netdev@vger.kernel.org>; Thu, 14 Dec 2023 03:12:36 -0800 (PST)
Received: by mail-wm1-x32f.google.com with SMTP id 5b1f17b1804b1-40c2308faedso82090255e9.1
        for <netdev@vger.kernel.org>; Thu, 14 Dec 2023 03:12:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702552354; x=1703157154; darn=vger.kernel.org;
        h=mime-version:user-agent:references:message-id:date:in-reply-to
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=HFLk90YJRJTdLAWuuobbT0hT4wL3qXQh3mzV6rk9Sig=;
        b=ABNE1//MS7iQFiwTSWvcOqnzpiaJ7dJAnklvLSn3iyVVwo+jAF7DX7mnpxY92oFa6c
         Vp5LCET1hQmjm6KBuN+d+IT+K5H6cy5aNy4vE/S4ZLWjTgKYUItr4ubNCAm/2lcCwIZt
         X3esJXoQJp00l1V5gFc2UXzOat0l/oRtHP3yJPZFx3BQPU+X7KMHxtEaBuki8/MRfBPa
         LbPgmZJv1Ppf2Lvo9t5BZqLfOUs2rJ6BGMj6Ys0s2R+t+2/2rx1Uobbds6kmXbnA7AYS
         EPH8Fyb42RUszGVLHGR+1rV4LzZOjRTYQLcmx1pFs3kphE/nCPoTOscQC0Pe1A0NTNeK
         Ba7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702552354; x=1703157154;
        h=mime-version:user-agent:references:message-id:date:in-reply-to
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HFLk90YJRJTdLAWuuobbT0hT4wL3qXQh3mzV6rk9Sig=;
        b=B2XeRO5/RUlQHMeVMa2hP3tFPSWx/S5nZzDek/gYtPmTyw7t3IaoguH3ZhAgJaO7cb
         euN9h46suiVnP1lC87Qzw753SO80PpNNOv6cE6MmoffQyeNEIJrVcEWdWBrJAPSO3elj
         ffxctic+LdtHGL49v0GicI03/Pw/P/0om4d6WPlN7w/TAUU0OIg3NDgnXqHM7wCJe859
         60pshZozFm/FWn1rl3KaUfNULd0GfuCvYJo2dY+l6funeYENCZmBS/C66t/k7nXindUm
         Cn+9psyP22JMbVhxXMK5R0Lif9uAR0ohhCvNGl9xIg+vF0fFhzrtl+sgKz6YqXzty+2p
         sFiA==
X-Gm-Message-State: AOJu0YzPqO08LRirc8wVtep53vHw0K+sUFgSgy2SGX1K7hAm+nVEpAZ1
	gKgjbNdOXfZQu/uBeFS9xS9YID2+aSqZKA==
X-Google-Smtp-Source: AGHT+IGYRIYnNJtsVqAZYaOj1lGnpUltn2JmwHx3MpEfMzcuCBD1dZaFY5YUPIwR6E3vfHzuGSXD7A==
X-Received: by 2002:a05:600c:1705:b0:40c:2a42:d7ec with SMTP id c5-20020a05600c170500b0040c2a42d7ecmr4390677wmn.57.1702552354309;
        Thu, 14 Dec 2023 03:12:34 -0800 (PST)
Received: from imac ([2a02:8010:60a0:0:7840:ddbd:bbf:1e8f])
        by smtp.gmail.com with ESMTPSA id r5-20020a05600c35c500b004080f0376a0sm24018828wmq.42.2023.12.14.03.12.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Dec 2023 03:12:33 -0800 (PST)
From: Donald Hunter <donald.hunter@gmail.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net,  netdev@vger.kernel.org,  edumazet@google.com,
  pabeni@redhat.com
Subject: Re: [PATCH net-next 2/3] netlink: specs: ovs: correct enum names in
 specs
In-Reply-To: <20231213232822.2950853-3-kuba@kernel.org> (Jakub Kicinski's
	message of "Wed, 13 Dec 2023 15:28:21 -0800")
Date: Thu, 14 Dec 2023 08:45:36 +0000
Message-ID: <m2jzph5g0f.fsf@gmail.com>
References: <20231213232822.2950853-1-kuba@kernel.org>
	<20231213232822.2950853-3-kuba@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Jakub Kicinski <kuba@kernel.org> writes:

> Align the enum-names of OVS with what's actually in the uAPI.
> Either correct the names, or mark the enum as empty because
> the values are in fact #defines.
>
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>

Reviewed-by: Donald Hunter <donald.hunter@gmail.com>

