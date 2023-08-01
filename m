Return-Path: <netdev+bounces-23028-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 51C6876A70A
	for <lists+netdev@lfdr.de>; Tue,  1 Aug 2023 04:36:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0DBF928185D
	for <lists+netdev@lfdr.de>; Tue,  1 Aug 2023 02:35:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B683807;
	Tue,  1 Aug 2023 02:35:57 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F71A7E4
	for <netdev@vger.kernel.org>; Tue,  1 Aug 2023 02:35:56 +0000 (UTC)
Received: from mail-il1-x135.google.com (mail-il1-x135.google.com [IPv6:2607:f8b0:4864:20::135])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0FB41BF6
	for <netdev@vger.kernel.org>; Mon, 31 Jul 2023 19:35:41 -0700 (PDT)
Received: by mail-il1-x135.google.com with SMTP id e9e14a558f8ab-348de515667so22798615ab.1
        for <netdev@vger.kernel.org>; Mon, 31 Jul 2023 19:35:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690857341; x=1691462141;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=C6AOWyDqc75GRxFgcgcfnofzEcWMYSjGod9lW80IX6E=;
        b=QOnPQLplydDtl+ZM2qfc+7pKQXNbEw5TjbTITfXYsKhwU+Sjkbjy9A98NHFcWE6/6c
         4pCHhZtChtWMR43J9OZOwArFE91MkORKqOwAyCdwNJBdqImDVHZNut/qBkRvNZccW2fC
         g40kOmhOiA/vKb5UMUYbf10VBbDwLUYdy6blgzx4hLFG5TvLc1zWUFuICAoE189aFmKM
         bNlUiln2Em5RFuqGTWJ1fjFwVDBAhl5PYu5vsWR6N5OF1owZkLHmmeQ4tZWzNnlCM8hF
         pR57NObghRNCyhEXLm0VUlKgO2+yRya8vZ50SrrUoEWPlom6kTQfx2cdU9khA1Ey7b6I
         TKDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690857341; x=1691462141;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=C6AOWyDqc75GRxFgcgcfnofzEcWMYSjGod9lW80IX6E=;
        b=OB/7U9RGF/0+zy3W6aCFyuLqZ/twka63EmPryQkTK11NqeXlMmDO3zLtAmymyxkKaQ
         dtWQ6X+Rr+BrL6rwE4SrRiEcwj8ck/VaI4l5Z2oGCtfNOvggtwWxjsUpIpogg8VFndev
         wMg0XjMBBUmjFq98Ywu7CdQIuR37e3rX9oRXlc6G3Nct7uu+PTPlaNjarAobGJ1S5ikl
         7EVKTvY5xSSVkec0z4VxMckDW1ACvX+Kb2qIjbToIacH6S7nl6QDMAYVQlhdkUvtyhs+
         aE/4D1kpvQA/52W7U6ujNrkgS2lRNIzrYaR85DKnDh6e1jeTrH0FXm9LeOYwEnTp/YmS
         E4CQ==
X-Gm-Message-State: ABy/qLahWRLI5W1+ixlWMNBAX5lMaBA9mOrBf6PiqObO02XMI3YpRqV+
	HgfYMzjNmiNsUS2/FioCwzo=
X-Google-Smtp-Source: APBJJlEYUv9I8KY/FXDFaBge/CfFbylJBABucKaeqnlXZu8MLKN4JUhY3ruYT2a0mxiYJEbiqq9SEQ==
X-Received: by 2002:a92:c54e:0:b0:348:d89b:268 with SMTP id a14-20020a92c54e000000b00348d89b0268mr12457449ilj.7.1690857340893;
        Mon, 31 Jul 2023 19:35:40 -0700 (PDT)
Received: from ?IPV6:2601:282:800:7ed0:211e:b7c4:92fe:76f4? ([2601:282:800:7ed0:211e:b7c4:92fe:76f4])
        by smtp.googlemail.com with ESMTPSA id c14-20020a02a60e000000b0041d859c5721sm3538656jam.64.2023.07.31.19.35.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 31 Jul 2023 19:35:40 -0700 (PDT)
Message-ID: <5222d4e2-dd19-fc77-23f0-ce96684e9470@gmail.com>
Date: Mon, 31 Jul 2023 20:35:39 -0600
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.13.0
Subject: Re: [PATCH iproute2-next] tc: Classifier support for SPI field
Content-Language: en-US
To: Ratheesh Kannoth <rkannoth@marvell.com>,
 "stephen@networkplumber.org" <stephen@networkplumber.org>
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 "davem@davemloft.net" <davem@davemloft.net>,
 "kuba@kernel.org" <kuba@kernel.org>, Leon Romanovsky <leon@kernel.org>,
 "edumazet@google.com" <edumazet@google.com>,
 "pabeni@redhat.com" <pabeni@redhat.com>
References: <20230725035016.505386-1-rkannoth@marvell.com>
 <MWHPR1801MB19182545B1FEB05CAC9F7371D30AA@MWHPR1801MB1918.namprd18.prod.outlook.com>
From: David Ahern <dsahern@gmail.com>
In-Reply-To: <MWHPR1801MB19182545B1FEB05CAC9F7371D30AA@MWHPR1801MB1918.namprd18.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 7/31/23 7:53 PM, Ratheesh Kannoth wrote:
>> From: Ratheesh Kannoth <rkannoth@marvell.com>
>> Sent: Tuesday, July 25, 2023 9:20 AM
>> To: dsahern@gmail.com; stephen@networkplumber.org
>> Cc: netdev@vger.kernel.org; Ratheesh Kannoth <rkannoth@marvell.com>
>> Subject: [PATCH iproute2-next] tc: Classifier support for SPI field
>>
>> tc flower support for SPI field in ESP and AH packets.
>>
>> Signed-off-by: Ratheesh Kannoth <rkannoth@marvell.com>
>> ---
>>  include/uapi/linux/pkt_cls.h |  5 +++-
>>  tc/f_flower.c                | 55 ++++++++++++++++++++++++++++++++++--
>>  2 files changed, 57 insertions(+), 3 deletions(-)
>>
>> diff --git a/include/uapi/linux/pkt_cls.h b/include/uapi/linux/pkt_cls.h index
>> 7865f5a9..fce639a6 100644
>> --- a/include/uapi/linux/pkt_cls.h
>> +++ b/include/uapi/linux/pkt_cls.h
>> @@ -594,6 +594,9 @@ enum {
>>
>>  	TCA_FLOWER_KEY_L2TPV3_SID,	/* be32 */
>>
>> +	TCA_FLOWER_KEY_SPI,		/* be32 */
>> +	TCA_FLOWER_KEY_SPI_MASK,	/* be32 */
>> +
>>  	TCA_FLOWER_L2_MISS,		/* u8 */
>>
>>  	TCA_FLOWER_KEY_CFM,		/* nested */
> 
> As per https://lore.kernel.org/netdev/20230731120254.GB87829@unreal/T/#u  ,  I will move these fields to  end in the enum.  
> Could you please discard https://patchwork.kernel.org/project/netdevbpf/patch/20230725035016.505386-1-rkannoth@marvell.com/  this  from netdev patchwork ?

you do not need to include uapi changes in an iproute2 patch; headers
are sync'ed from the kernel.


