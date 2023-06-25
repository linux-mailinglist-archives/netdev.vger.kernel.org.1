Return-Path: <netdev+bounces-13840-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9021373D390
	for <lists+netdev@lfdr.de>; Sun, 25 Jun 2023 22:15:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4F48F1C208E4
	for <lists+netdev@lfdr.de>; Sun, 25 Jun 2023 20:15:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CF0C8F48;
	Sun, 25 Jun 2023 20:14:58 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E8717464
	for <netdev@vger.kernel.org>; Sun, 25 Jun 2023 20:14:57 +0000 (UTC)
Received: from smtp.smtpout.orange.fr (smtp-28.smtpout.orange.fr [80.12.242.28])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A02C1AD
	for <netdev@vger.kernel.org>; Sun, 25 Jun 2023 13:14:54 -0700 (PDT)
Received: from [192.168.1.18] ([86.243.2.178])
	by smtp.orange.fr with ESMTPA
	id DW8Hql8IdYSjeDW8Hq54KJ; Sun, 25 Jun 2023 22:14:52 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
	s=t20230301; t=1687724092;
	bh=99Zy3Wa/tHoUx/okcXBe0djEuGdAxqRHAp5/pcQcgbo=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=ahA6Jg46mNlm/+eOaIE9unvhul6T3L5VFkMdRe5rS4cSJcS9ViXR0/zBB6icUDT8Z
	 bnEIAEGfz3VM6yCSNk5++YjQkVSikNbppFRqdIPaTKJMnOQJEXmwe+/u8YOf9q77oX
	 DQFcysCT9RrzsMdyLElAL7FBifDdFyNUW6qtGTJkjZfdkzb3nmSlGZRA/W6+ANl8Tk
	 JI2zCHBJexBlikkTwL3aMdu/z1DnkFosVv7yw56UtUDttQ7DAgusUVLET8PHqBinEn
	 7jzdgAqRysNCCIUJhUlvOim9Biv2RoLk4bq/lsbpNHPSZyh1J97aBriOQq00ONPf0x
	 HSbwl7ZDPb3KQ==
X-ME-Helo: [192.168.1.18]
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Sun, 25 Jun 2023 22:14:52 +0200
X-ME-IP: 86.243.2.178
Message-ID: <beb409e3-0c13-b817-dfa3-15792a341130@wanadoo.fr>
Date: Sun, 25 Jun 2023 22:14:49 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH 02/26] octeon_ep: use array_size
To: Jakub Kicinski <kuba@kernel.org>, Julia Lawall <Julia.Lawall@inria.fr>
Cc: Veerasenareddy Burru <vburru@marvell.com>, keescook@chromium.org,
 kernel-janitors@vger.kernel.org, Abhijit Ayarekar <aayarekar@marvell.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, corbet@lwn.net
References: <20230623211457.102544-1-Julia.Lawall@inria.fr>
 <20230623211457.102544-3-Julia.Lawall@inria.fr>
 <20230624152826.10e3789b@kernel.org>
Content-Language: fr
From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
In-Reply-To: <20230624152826.10e3789b@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
	RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
	T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Le 25/06/2023 à 00:28, Jakub Kicinski a écrit :
> On Fri, 23 Jun 2023 23:14:33 +0200 Julia Lawall wrote:
>> -	oq->buff_info = vzalloc(oq->max_count * OCTEP_OQ_RECVBUF_SIZE);
>> +	oq->buff_info = vzalloc(array_size(oq->max_count, OCTEP_OQ_RECVBUF_SIZE));
> 
> vcalloc seems to exist, is there a reason array_size() is preferred?

Hi,

just for your information, I've just sent [1].

CJ

[1]: 
https://lore.kernel.org/all/3484e46180dd2cf05d993ff1a78b481bc2ad1f71.1687723931.git.christophe.jaillet@wanadoo.fr/


