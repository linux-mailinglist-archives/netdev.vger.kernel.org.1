Return-Path: <netdev+bounces-33509-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 71C4179E52A
	for <lists+netdev@lfdr.de>; Wed, 13 Sep 2023 12:46:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ECF91281809
	for <lists+netdev@lfdr.de>; Wed, 13 Sep 2023 10:46:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDCDB179B0;
	Wed, 13 Sep 2023 10:46:51 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD9EE1775D
	for <netdev@vger.kernel.org>; Wed, 13 Sep 2023 10:46:51 +0000 (UTC)
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D805619B0
	for <netdev@vger.kernel.org>; Wed, 13 Sep 2023 03:46:50 -0700 (PDT)
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-402ba03c754so18977895e9.0
        for <netdev@vger.kernel.org>; Wed, 13 Sep 2023 03:46:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694602009; x=1695206809;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1IJ6dOeSQoal459gpLXC+2pZvArZBH8dyyX/X+2VWdY=;
        b=RqgWGLdPAbIViBllVX9XPG9yU1vwqiygJpgnlbYNOUv7BQ6wA8afNuDu3LaiAa0Kcm
         Ym5UrWnncyhYJo3WCz08OGilZ2PpDzN203A4OyJLDLj50nYFOemr9K548DRvmUaFR4PL
         szQePrechfmbDhBNmmqun/p7G0pwVRzdes8+zZl8uIZ/UmC8y3y4CngHyRJ0WpE0ujFw
         kvfZ+K8DUgBQ9L4SdnQZRaib1JET58q6gFufEcmctstdjb7b46X0Q66kdWssaDy9ZbGv
         sUpBbBoHmQ1ASr3W6Iy1NNFQl16CC3oltfkRIwEdj/+IQUWcXScedKG7PFuylfADCnJU
         Fjyg==
X-Gm-Message-State: AOJu0Yzm7s7m4F5/PrXO5eptGXM1Ec2BiX+pGp1Ahit9RrfGexnKyUea
	hpK5N9jKaW6arQDe5s6lgb0=
X-Google-Smtp-Source: AGHT+IH2xOZSOHu8J1Ac+kKC8FBAG+bM0DPd11pNU5K57bzQAl5oNX9Zq4Lprv8v0XpO6EmutdKEWA==
X-Received: by 2002:a05:600c:1c86:b0:401:d8a4:17b0 with SMTP id k6-20020a05600c1c8600b00401d8a417b0mr1724095wms.2.1694602008981;
        Wed, 13 Sep 2023 03:46:48 -0700 (PDT)
Received: from [192.168.64.157] (bzq-219-42-90.isdn.bezeqint.net. [62.219.42.90])
        by smtp.gmail.com with ESMTPSA id l14-20020a1c790e000000b003fe4ca8decdsm1657334wme.31.2023.09.13.03.46.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 13 Sep 2023 03:46:48 -0700 (PDT)
Message-ID: <93a30515-c85d-3942-29d9-ad6bb0e869e5@grimberg.me>
Date: Wed, 13 Sep 2023 13:46:45 +0300
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Subject: Re: [PATCH v15 05/20] nvme-tcp: Add DDP offload control path
Content-Language: en-US
To: Aurelien Aptel <aaptel@nvidia.com>, linux-nvme@lists.infradead.org,
 netdev@vger.kernel.org, hch@lst.de, kbusch@kernel.org, axboe@fb.com,
 chaitanyak@nvidia.com, davem@davemloft.net, kuba@kernel.org
Cc: Boris Pismenny <borisp@nvidia.com>, aurelien.aptel@gmail.com,
 smalin@nvidia.com, malin1024@gmail.com, ogerlitz@nvidia.com,
 yorayz@nvidia.com, galshalom@nvidia.com, mgurtovoy@nvidia.com
References: <20230912095949.5474-1-aaptel@nvidia.com>
 <20230912095949.5474-6-aaptel@nvidia.com>
 <db2cbdc2-2a6d-a632-3584-6aeafc5738e2@grimberg.me>
 <253edj2h20j.fsf@mtr-vdi-124.i-did-not-set--mail-host-address--so-tickle-me>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <253edj2h20j.fsf@mtr-vdi-124.i-did-not-set--mail-host-address--so-tickle-me>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 9/13/23 12:10, Aurelien Aptel wrote:
> Sagi Grimberg <sagi@grimberg.me> writes:
>>> +     if (test_bit(NVME_TCP_Q_OFF_DDP, &queue->flags))
>>> +             nvme_tcp_unoffload_socket(queue);
>>> +#ifdef CONFIG_ULP_DDP
>>> +     if (nvme_tcp_admin_queue(queue) && queue->ctrl->ddp_netdev) {
>>> +             /* put back ref from get_netdev_for_sock() */
>>> +             dev_put(queue->ctrl->ddp_netdev);
>>> +             queue->ctrl->ddp_netdev = NULL;
>>> +     }
>>> +#endif
>>
>> Lets avoid spraying these ifdefs in the code.
>> the ddp_netdev struct member can be lifted out of the ifdef I think
>> because its only controller-wide.
>>
> 
> Ok, we will remove the ifdefs.
> 
>>> +#ifdef CONFIG_ULP_DDP
>>> +             /*
>>> +              * Admin queue takes a netdev ref here, and puts it
>>> +              * when the queue is stopped in __nvme_tcp_stop_queue().
>>> +              */
>>> +             ctrl->ddp_netdev = get_netdev_for_sock(queue->sock->sk);
>>> +             if (ctrl->ddp_netdev) {
>>> +                     if (nvme_tcp_ddp_query_limits(ctrl)) {
>>> +                             nvme_tcp_ddp_apply_limits(ctrl);
>>> +                     } else {
>>> +                             dev_put(ctrl->ddp_netdev);
>>> +                             ctrl->ddp_netdev = NULL;
>>> +                     }
>>> +             } else {
>>> +                     dev_info(nctrl->device, "netdev not found\n");
>>
>> Would prefer to not print offload specific messages in non-offload code
>> paths. at best, dev_dbg.
> 
> Sure, we will switch to dev_dbg.
> 
>> If the netdev is derived by the sk, why does the interface need a netdev
>> at all? why not just pass sk and derive the netdev from the sk behind
>> the interface?
>>
>> Or is there a case that I'm not seeing here?
> 
> If we derive the netdev from the socket, it would be too costly to call
> get_netdev_for_sock() which takes a lock on the data path.
> 
> We could store it in the existing sk->ulp_ddp_ctx, assigning it in
> sk_add and accessing it in sk_del/setup/teardown/resync.
> But we would run into the problem of not being sure
> get_netdev_for_sock() returned the same device in query_limits() and
> sk_add() because we did not keep a pointer to it.
> 
> We believe it would be more complex to deal with these problems than to
> just keep a reference to the netdev in the nvme-tcp controller.
> 

OK, Seems though that the netdev and the limits are bundled together,
meaning that you either get both or none.

Perhaps you should bundle them together:
	ctrl->ddp_netdev = nvme_tcp_get_ddp_netdev_with_limits(ctrl);
	if (ctrl->ddp_netdev)
		nvme_tcp_ddp_apply_ctrl_limits(ctrl);

where:
static struct net_device* nvme_tcp_get_ddp_netdev_with_limits(struct 
nvme_tcp_ctrl *ctrl)
{
	if (!ddp_offload)
		return NULL;
	netdev = get_netdev_for_sock(ctrl->queues[0].sock->sk);
	if (!netdev)
		return NULL;
	ret = ulp_ddp_query_limits(netdev, &ctrl->ddp_limits,
				ULP_DDP_NVME, ULP_DDP_C_NVME_TCP_BIT,
				false /* tls */);
	if (ret) {
		dev_put(netdev);
		return NULL;
	}
	return netdev;
}

And perhaps its time to introduce nvme_tcp_stop_admin_queue()?
static void nvme_tcp_stop_admin_queue(struct nvme_ctrl *nctrl)
{
	struct nvme_tcp_ctrl *ctrl = to_tcp_ctrl(nctrl);

	nvme_tcp_stop_queue(nctrl, 0);
	dev_put(ctrl->ddp_netdev);
}

