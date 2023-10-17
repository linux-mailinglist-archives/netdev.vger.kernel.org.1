Return-Path: <netdev+bounces-41795-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 137427CBE75
	for <lists+netdev@lfdr.de>; Tue, 17 Oct 2023 11:07:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C3A46281960
	for <lists+netdev@lfdr.de>; Tue, 17 Oct 2023 09:07:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4AF63E460;
	Tue, 17 Oct 2023 09:07:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blackwall-org.20230601.gappssmtp.com header.i=@blackwall-org.20230601.gappssmtp.com header.b="n21GhRfT"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82ABA38FA0
	for <netdev@vger.kernel.org>; Tue, 17 Oct 2023 09:07:03 +0000 (UTC)
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20C3C8E
	for <netdev@vger.kernel.org>; Tue, 17 Oct 2023 02:07:02 -0700 (PDT)
Received: by mail-wm1-x32b.google.com with SMTP id 5b1f17b1804b1-40806e40fccso2216725e9.2
        for <netdev@vger.kernel.org>; Tue, 17 Oct 2023 02:07:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall-org.20230601.gappssmtp.com; s=20230601; t=1697533620; x=1698138420; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=bgo6/o6F9GJ+i/Na8KtZEjz2ourig29cQcy60o4Bri8=;
        b=n21GhRfT2NJi4WPXDg/fyX61xtJnUUmWgkMXESlGCdRS0ZmO0PGlPPVj+sxtMgnmzE
         lUver2h6mHyj0hUujAhRg3twF4Lf+OvvcxBOSrC4ewfT23B9oHaKcFuoonRWFgEvwse9
         +XLHY5U6OqqD0pZbezCGCRM2j5CWtzXhXXCDlAKe/JWU6jaDtjgtFdtf013x6jsutLlC
         ef0eqKt7tC79E7BaIYCZrZjcnuWuZNdz9LAQuz6I5gAg3EcojHsidOcpc/5Um7oQqTac
         n6Dh+4TUw8WlaRskrbxAqIYvFhRUVyM0nv8JLJVSKXyNoNoKPziEBTk0cUhoQimtlknA
         XluQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697533620; x=1698138420;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bgo6/o6F9GJ+i/Na8KtZEjz2ourig29cQcy60o4Bri8=;
        b=kv6P0LclFVIolRHIWhqYgBXzYNw4bxB4+kSMlO1iownFZ0uMhtOuKL9Il40pUdnPjZ
         Dk0HOxSDQBGyG8m8FLdMTGG2y8jCOVFCt/OlJ1RnHsZfenwP3kMRZEYrHi9zLqhByIcj
         OTDs6J/l+EI00HA3HjYGp6NsdKkA/e3Wt/Zcfu31G6eIHwgHeUnGrxQmmArllJfM35Bj
         LrvD2mQQnc4aCD02zChKmFbllyp7EmmGgSvK2EoXB38p+Oj0zigtZser1MFxWy1IAqUN
         oAfmEdT0OMZlaqp9HF9na4IBDsXUfc9kH71oIVzyyrGU4prLSZUtjil3d0EH1lDHL7u3
         kNaQ==
X-Gm-Message-State: AOJu0YzUOac8KszeqOnrSHh+An4I+hJcepDSE/btv6qqD7N5KRpQZ/vP
	0hx1rFud2+ARATjDfekH2d190fCoRwuIzoIeFUkL157rRdY=
X-Google-Smtp-Source: AGHT+IFGCbvsS0uOcmJ8+ZdWpIAM6yyY3hI4h1XxALIkv8szD7Wg3MZXpQLMEVqrRb3Pn1lOG0msNw==
X-Received: by 2002:adf:e60b:0:b0:31c:8880:5d0f with SMTP id p11-20020adfe60b000000b0031c88805d0fmr1440738wrm.11.1697533620599;
        Tue, 17 Oct 2023 02:07:00 -0700 (PDT)
Received: from [192.168.0.106] (haunt.prize.volia.net. [93.72.109.136])
        by smtp.gmail.com with ESMTPSA id v9-20020adfedc9000000b00323287186aasm1212079wro.32.2023.10.17.02.06.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 17 Oct 2023 02:07:00 -0700 (PDT)
Message-ID: <7a6e6266-2450-4838-3629-0d3d8d43f11e@blackwall.org>
Date: Tue, 17 Oct 2023 12:06:54 +0300
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH net-next 06/13] vxlan: mdb: Factor out a helper for remote
 entry size calculation
Content-Language: en-US
To: Ido Schimmel <idosch@nvidia.com>, netdev@vger.kernel.org,
 bridge@lists.linux-foundation.org
Cc: davem@davemloft.net, kuba@kernel.org, edumazet@google.com,
 pabeni@redhat.com, roopa@nvidia.com, mlxsw@nvidia.com
References: <20231016131259.3302298-1-idosch@nvidia.com>
 <20231016131259.3302298-7-idosch@nvidia.com>
From: Nikolay Aleksandrov <razor@blackwall.org>
In-Reply-To: <20231016131259.3302298-7-idosch@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 10/16/23 16:12, Ido Schimmel wrote:
> Currently, netlink notifications are sent for individual remote entries
> and not for the entire MDB entry itself.
> 
> Subsequent patches are going to add MDB get support which will require
> the VXLAN driver to reply with an entire MDB entry.
> 
> Therefore, as a preparation, factor out a helper to calculate the size
> of an individual remote entry. When determining the size of the reply
> this helper will be invoked for each remote entry in the MDB entry.
> 
> No functional changes intended.
> 
> Signed-off-by: Ido Schimmel <idosch@nvidia.com>
> ---
>   drivers/net/vxlan/vxlan_mdb.c | 28 +++++++++++++++++++---------
>   1 file changed, 19 insertions(+), 9 deletions(-)
> 

Acked-by: Nikolay Aleksandrov <razor@blackwall.org>



