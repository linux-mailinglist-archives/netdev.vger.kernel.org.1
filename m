Return-Path: <netdev+bounces-36517-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A1E27B036E
	for <lists+netdev@lfdr.de>; Wed, 27 Sep 2023 14:03:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by ny.mirrors.kernel.org (Postfix) with ESMTP id 92B7E1C20842
	for <lists+netdev@lfdr.de>; Wed, 27 Sep 2023 12:03:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F142514AA9;
	Wed, 27 Sep 2023 12:03:14 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EB482C9D
	for <netdev@vger.kernel.org>; Wed, 27 Sep 2023 12:03:13 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AEDC9FC
	for <netdev@vger.kernel.org>; Wed, 27 Sep 2023 05:03:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1695816190;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=OIJdWPFNkLfDudtONt3WjWlis6fmp6gJVF1FOUUG9fU=;
	b=dJ/V5CGeFo375LDmCLRFuQBwzQlU96E1RGWtDKZIEGxn+6Pili4+/ZBknZkUVYnajA8bWi
	ulKq4jeuGzNmz59yQO27UkMSt9/knazeJuM4sy0Svj4fUWqGxP3rVxd5Fr+oO3HZXANuQK
	44VpopSZGQ5u7428AxThkH1Nn0GbYZ0=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-333-okpOu4MBNR-slWFkax51QA-1; Wed, 27 Sep 2023 08:03:09 -0400
X-MC-Unique: okpOu4MBNR-slWFkax51QA-1
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-77407e21d49so1791223685a.0
        for <netdev@vger.kernel.org>; Wed, 27 Sep 2023 05:03:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695816189; x=1696420989;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=OIJdWPFNkLfDudtONt3WjWlis6fmp6gJVF1FOUUG9fU=;
        b=a/s8C5fnzGJfucw+5IVDFWUpcTKMSRayGEV1KspTic7Sgdjro0DUqgtENEkVnwsQl2
         zIGC+Xnj03bBHXCPZ3lL5UYZ9TaMn+konO49J14Q6j41vhK4SRO48c9f26247LSdibGw
         KmC01DprXcNK60C+J4n0il7AoZLAzx7H1B52p3GRqvXZwrEBqXlxj+SghwznYafIWls/
         mzPu0DQPRj+SUo4OAZw1QXrwcTfsi45IzLWAfw4FVSAxBjoWh7xDt8Ha8f3gf4IsFBW9
         aT67IBfabey1lEWAMEys0W1tEjaF9+lQ7LYAzPMMSKH0K3YJxzp0Og+O+4tajmFatIsy
         FxZg==
X-Gm-Message-State: AOJu0YxKhd/8wpCLSSdGYBEss+M46roivBF/3/rpHifPWqV+GNzW91bb
	OfvjUnF9cokA1L0ljzYy+T7U13rpokB3is9HMKL3H3l0JgahFXmm4jduEmReLOZekeAH6Z2AK4y
	ERa9CsR43ej7TR8e2
X-Received: by 2002:a05:620a:3885:b0:774:108a:b537 with SMTP id qp5-20020a05620a388500b00774108ab537mr1323439qkn.42.1695816188941;
        Wed, 27 Sep 2023 05:03:08 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG/e4xgrXENJoifhRKXLsQ1PlmJmOxOGeD34II+VIHXNNhkFbt7ctmSpSSOxYIwcBi5qLWAQQ==
X-Received: by 2002:a05:620a:3885:b0:774:108a:b537 with SMTP id qp5-20020a05620a388500b00774108ab537mr1323395qkn.42.1695816188475;
        Wed, 27 Sep 2023 05:03:08 -0700 (PDT)
Received: from [10.16.200.42] (nat-pool-bos-t.redhat.com. [66.187.233.206])
        by smtp.gmail.com with ESMTPSA id w15-20020ae9e50f000000b0077423f849c3sm3607412qkf.24.2023.09.27.05.03.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 27 Sep 2023 05:03:07 -0700 (PDT)
Message-ID: <2010c7a4-8754-2563-cd55-35bdd854d04e@redhat.com>
Date: Wed, 27 Sep 2023 08:03:06 -0400
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH] net: appletalk: remove cops support
Content-Language: en-US
To: Christoph Hellwig <hch@infradead.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-spdx@vger.kernel.org, Vitaly Kuznetsov <vkuznets@redhat.com>,
 jschlst@samba.org
References: <20230927090029.44704-2-gregkh@linuxfoundation.org>
 <ZRP1R65q43PZj7pc@infradead.org>
From: Prarit Bhargava <prarit@redhat.com>
In-Reply-To: <ZRP1R65q43PZj7pc@infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
	RCVD_IN_SORBS_WEB,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 9/27/23 05:26, Christoph Hellwig wrote:
> On Wed, Sep 27, 2023 at 11:00:30AM +0200, Greg Kroah-Hartman wrote:
>> The COPS Appletalk support is very old, never said to actually work
>> properly, and the firmware code for the devices are under a very suspect
>> license.  Remove it all to clear up the license issue, if it is still
>> needed and actually used by anyone, we can add it back later once the
>> license is cleared up.
> 
> Looks good:
> 
> Acked-by: Christoph Hellwig <hch@lst.de>
> 

Ditto.

Acked-by: Prarit Bhargava <prarit@redhat.com>

P.


