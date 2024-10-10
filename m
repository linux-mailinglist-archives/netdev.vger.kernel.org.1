Return-Path: <netdev+bounces-134184-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 50F7A998503
	for <lists+netdev@lfdr.de>; Thu, 10 Oct 2024 13:32:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 785611C22AE1
	for <lists+netdev@lfdr.de>; Thu, 10 Oct 2024 11:32:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62A141BE874;
	Thu, 10 Oct 2024 11:32:42 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 307A333CD2;
	Thu, 10 Oct 2024 11:32:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.255
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728559962; cv=none; b=H4O32mMz+i+7utIPeJYJDtPuCD+hpJUFJN61RelX7qtDqbT8cFFO8j85+NNqQuZKrmhClovvDlAQEJVHlsA8E9/HKE80SQINXVQPNM1SXz7jd4iWpL7jxH5A5UgFC62nvlMuoQ2tY4/ofUDuCzuq0R+O/es9gd2dROVTtVQGqFg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728559962; c=relaxed/simple;
	bh=tUhIh7iS7rv6oABGOO9xKekcfsc5+3qZNkufukd1RcE=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=ci0qQT1/WhEcA6Sc0UzcFRvFK2jnfT78FuNBvTz6SRH+QKJZIr3tGfCwaTL+jZG2CqKZoXTOIuVhGZvpALgxQfOHJqHPI94nY1vhOc6OiC8pfULfgNbpchbbb0FSc0dwwRZDNhjmhcEx3BejSKLI9xJDCncii0m0q6uJOEXnGUc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.255
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.162.254])
	by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4XPSHd1qv0z1T7ZR;
	Thu, 10 Oct 2024 19:30:53 +0800 (CST)
Received: from dggpemf200006.china.huawei.com (unknown [7.185.36.61])
	by mail.maildlp.com (Postfix) with ESMTPS id E924E18010F;
	Thu, 10 Oct 2024 19:32:37 +0800 (CST)
Received: from [10.67.120.129] (10.67.120.129) by
 dggpemf200006.china.huawei.com (7.185.36.61) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Thu, 10 Oct 2024 19:32:37 +0800
Message-ID: <fa578d46-d898-4d29-b42b-cb93c57bdc5f@huawei.com>
Date: Thu, 10 Oct 2024 19:32:37 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v20 09/14] net: rename skb_copy_to_page_nocache()
 helper
To: Alexander Duyck <alexander.duyck@gmail.com>
CC: <davem@davemloft.net>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Eric Dumazet
	<edumazet@google.com>, David Ahern <dsahern@kernel.org>
References: <20241008112049.2279307-1-linyunsheng@huawei.com>
 <20241008112049.2279307-10-linyunsheng@huawei.com>
 <CAKgT0Ue_mp1JB2XffSx-9siR4V6u3U_jEyy91BUqTS9C6TJ5mw@mail.gmail.com>
Content-Language: en-US
From: Yunsheng Lin <linyunsheng@huawei.com>
In-Reply-To: <CAKgT0Ue_mp1JB2XffSx-9siR4V6u3U_jEyy91BUqTS9C6TJ5mw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 dggpemf200006.china.huawei.com (7.185.36.61)

On 2024/10/10 7:40, Alexander Duyck wrote:
> On Tue, Oct 8, 2024 at 4:27 AM Yunsheng Lin <linyunsheng@huawei.com> wrote:
>>
>> Rename skb_copy_to_page_nocache() to skb_add_frag_nocache()
>> to avoid calling virt_to_page() as we are about to pass virtual
>> address directly.
>>
>> CC: Alexander Duyck <alexander.duyck@gmail.com>
>> Signed-off-by: Yunsheng Lin <linyunsheng@huawei.com>
>> ---
>>  include/net/sock.h | 9 +++------
>>  net/ipv4/tcp.c     | 7 +++----
>>  net/kcm/kcmsock.c  | 7 +++----
>>  3 files changed, 9 insertions(+), 14 deletions(-)
>>
>> diff --git a/include/net/sock.h b/include/net/sock.h
>> index e282127092ab..e0b4e2daca5d 100644
>> --- a/include/net/sock.h
>> +++ b/include/net/sock.h
>> @@ -2192,15 +2192,12 @@ static inline int skb_add_data_nocache(struct sock *sk, struct sk_buff *skb,
>>         return err;
>>  }
>>
>> -static inline int skb_copy_to_page_nocache(struct sock *sk, struct iov_iter *from,
>> -                                          struct sk_buff *skb,
>> -                                          struct page *page,
>> -                                          int off, int copy)
>> +static inline int skb_add_frag_nocache(struct sock *sk, struct iov_iter *from,
>> +                                      struct sk_buff *skb, char *va, int copy)
> 
> This is not adding a frag. It is copying to a frag. This naming is a
> hard no as there are functions that actually add frags to the skb and
> this is not what this is doing. It sounds like it should be some
> variant on skb_add_rx_frag and it isn't.
> 
> Instead of "_add_" I would suggest you stick with "_copy_to_" as the
> action as the alternative would be confusing as it implies you are
> going to be adding this to frags yourself.

I though we had reached a agreement in [1]? I guessed the 'That works
for me' only refer to the 'sk_' prefix?

The argumemt is that "skb_add_data_nocache() does memcpy'ing to skb->data
and update skb->len only by calling skb_put()" without calling something as
pskb_expand_head() to add more tailroom, so skb_add_frag_nocache is mirroring
that.

Does it mean skb_add_data_nocache() may be renamed to skb_copy_to_data_nocache()
in the future?

1. https://lore.kernel.org/all/CAKgT0Ue=tX+hKWiXQaM-6ypZ8fGvcUagGKfVrNGtRHVuhMX80g@mail.gmail.com/



