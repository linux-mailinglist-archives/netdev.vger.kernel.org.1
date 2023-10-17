Return-Path: <netdev+bounces-41790-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BB7E57CBE66
	for <lists+netdev@lfdr.de>; Tue, 17 Oct 2023 11:05:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 69A0DB20F34
	for <lists+netdev@lfdr.de>; Tue, 17 Oct 2023 09:05:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87AFA3D979;
	Tue, 17 Oct 2023 09:05:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blackwall-org.20230601.gappssmtp.com header.i=@blackwall-org.20230601.gappssmtp.com header.b="ni4BtECI"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F295CC15F
	for <netdev@vger.kernel.org>; Tue, 17 Oct 2023 09:05:18 +0000 (UTC)
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD79993
	for <netdev@vger.kernel.org>; Tue, 17 Oct 2023 02:05:17 -0700 (PDT)
Received: by mail-wm1-x32f.google.com with SMTP id 5b1f17b1804b1-40806e40fccso2205065e9.2
        for <netdev@vger.kernel.org>; Tue, 17 Oct 2023 02:05:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall-org.20230601.gappssmtp.com; s=20230601; t=1697533516; x=1698138316; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=cQobCh/g2E6pWLZRUcsnyARFUdw85tRKijfEAX7VrEw=;
        b=ni4BtECIJ/y2tTetUG5D5J+xozIsSIyBOdPNEIeFqJhWfsid6hVdq0LxgdmjD4b4vX
         MalssM+zGETQ4K4zuOLnXdxSys8ocTqxZZBTpzwccFc+FhGAQqFRehaeSRvOoIyYVDno
         ltaoL3vuZw7w8mlsP/NnJeppOXtXfPfGow/no2RdBhhhOa04kfqXKt2VjRofDJ4ynlWD
         aRYoHfl69aA83c0GVVGqXDcVaYm6TLx9+N6SmIFNNjRIbcqLX/dAF95comvcujelJYfT
         btsksX8g+dMD1a99qcTlZ53LW2RVgcleOfqLLG2V/UetBehynMsMYO2kA1SdlsXymKn8
         zY6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697533516; x=1698138316;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cQobCh/g2E6pWLZRUcsnyARFUdw85tRKijfEAX7VrEw=;
        b=Rspffgsn4F9MuYYV1zd3Q4ZrgSutWq0jm0NEItU8Hz7KeoceJ3hyWu6TFgTFwJWNvX
         +MqwhLHYDj1etW1/DzDabMBd07+7H3ZVtWDGARc71KU43hCRNJ7QZU5kS1yA1OrNiLKR
         N0COnz3wjFBzJTUwDGE1Mjqla+3FIE5mgm0BYHMqZblNtg19u7R6XkkjDMCl2VdHKfQ1
         j+wCKDC9iLV7xCN++PySzpDWVHVuba8qw5dUeaGXAYu0ixSheYTQmV6nnyC2GSQwpUVk
         npUTuZ/Ax4Gcu0k/eEnHDAYTWqKrZFBRgxEMvFvVETsvDd8ZoE+Vl9P9oMBX/8NyjVPY
         k14Q==
X-Gm-Message-State: AOJu0YwhPncETDZxQpZhnjMJajrLYY94S64XvNnGt7F1WtwrLme2ezv1
	WLU9J2AruO4HkfjTAA7lGnXNjw==
X-Google-Smtp-Source: AGHT+IF0nPcEY5QCyjfcGXmi5f3ifq4uFLj55kLfSAzlvZhLPfQaDvBmGoIMXsJrBvIbuQB70/dPqA==
X-Received: by 2002:a05:600c:468d:b0:407:566c:a9e3 with SMTP id p13-20020a05600c468d00b00407566ca9e3mr1160630wmo.21.1697533516073;
        Tue, 17 Oct 2023 02:05:16 -0700 (PDT)
Received: from [192.168.0.106] (haunt.prize.volia.net. [93.72.109.136])
        by smtp.gmail.com with ESMTPSA id bg5-20020a05600c3c8500b00405bbfd5d16sm1371218wmb.7.2023.10.17.02.05.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 17 Oct 2023 02:05:15 -0700 (PDT)
Message-ID: <48fcf444-f411-b4de-7ece-9ec2dfe89d47@blackwall.org>
Date: Tue, 17 Oct 2023 12:05:14 +0300
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH net-next 02/13] bridge: mcast: Account for missing
 attributes
Content-Language: en-US
To: Ido Schimmel <idosch@nvidia.com>, netdev@vger.kernel.org,
 bridge@lists.linux-foundation.org
Cc: davem@davemloft.net, kuba@kernel.org, edumazet@google.com,
 pabeni@redhat.com, roopa@nvidia.com, mlxsw@nvidia.com
References: <20231016131259.3302298-1-idosch@nvidia.com>
 <20231016131259.3302298-3-idosch@nvidia.com>
From: Nikolay Aleksandrov <razor@blackwall.org>
In-Reply-To: <20231016131259.3302298-3-idosch@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 10/16/23 16:12, Ido Schimmel wrote:
> The 'MDBA_MDB' and 'MDBA_MDB_ENTRY' nest attributes are not accounted
> for when calculating the size of MDB notifications. Add them along with
> comments for existing attributes.
> 
> Signed-off-by: Ido Schimmel <idosch@nvidia.com>
> ---
>   net/bridge/br_mdb.c | 15 +++++++++++----
>   1 file changed, 11 insertions(+), 4 deletions(-)
> 
> diff --git a/net/bridge/br_mdb.c b/net/bridge/br_mdb.c
> index fb58bb1b60e8..08de94bffc12 100644
> --- a/net/bridge/br_mdb.c
> +++ b/net/bridge/br_mdb.c
> @@ -452,11 +452,18 @@ static int nlmsg_populate_mdb_fill(struct sk_buff *skb,
>   
>   static size_t rtnl_mdb_nlmsg_size(struct net_bridge_port_group *pg)
>   {
> -	size_t nlmsg_size = NLMSG_ALIGN(sizeof(struct br_port_msg)) +
> -			    nla_total_size(sizeof(struct br_mdb_entry)) +
> -			    nla_total_size(sizeof(u32));
>   	struct net_bridge_group_src *ent;
> -	size_t addr_size = 0;
> +	size_t nlmsg_size, addr_size = 0;
> +
> +	nlmsg_size = NLMSG_ALIGN(sizeof(struct br_port_msg)) +
> +		     /* MDBA_MDB */
> +		     nla_total_size(0) +
> +		     /* MDBA_MDB_ENTRY */
> +		     nla_total_size(0) +
> +		     /* MDBA_MDB_ENTRY_INFO */
> +		     nla_total_size(sizeof(struct br_mdb_entry)) +
> +		     /* MDBA_MDB_EATTR_TIMER */
> +		     nla_total_size(sizeof(u32));
>   
>   	if (!pg)
>   		goto out;

Acked-by: Nikolay Aleksandrov <razor@blackwall.org>


