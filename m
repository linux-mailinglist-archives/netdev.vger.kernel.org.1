Return-Path: <netdev+bounces-62522-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 37D99827A36
	for <lists+netdev@lfdr.de>; Mon,  8 Jan 2024 22:31:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9D3731F2352E
	for <lists+netdev@lfdr.de>; Mon,  8 Jan 2024 21:30:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA48156440;
	Mon,  8 Jan 2024 21:30:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XxFTBPVm"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F36FB56441
	for <netdev@vger.kernel.org>; Mon,  8 Jan 2024 21:30:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-336c8ab0b20so2275066f8f.1
        for <netdev@vger.kernel.org>; Mon, 08 Jan 2024 13:30:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704749452; x=1705354252; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ilGiLSLcA6KptZiRKFiEiaSE6gYcyL5Ni/CZa+fziVE=;
        b=XxFTBPVmqbOiLAT4DVq7uunv/kV1GRIzEVgEjuFaYyRtK1FKLB39wIsTKgITDrQqZR
         ByHOif8xzEDmjaxQ0zaXRZE30oRKXxqk3qW6v+wLjvYyqJxki5NYFu7Ms/cY4kfVmahZ
         L3+DLjWV02/owsvOuEqyn4F1U8ZhLDifIxdUmC4aNjGe1V9eU4U8p1PXPaQBCpi/41j/
         gOoBtwCWEFE442DqpqFcmk28WPgytjOdBu80oWqVyLeQJkQwLBRGI/D5b2foQS/TVYdP
         nkxObftudpRW0gKZs49BHAmgpZVaziLrt2h5jGiS7DPzdxnnkI73vVddp5+ECztwCwUR
         TuWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704749452; x=1705354252;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ilGiLSLcA6KptZiRKFiEiaSE6gYcyL5Ni/CZa+fziVE=;
        b=qEYbf1HN2mw+iEEeJlbkYh646l7HlejSnHnzyfF04FHdpob8OkRJU/P+TPtg17Ja3M
         tc6rGGW2YrJHaHtBGLIMl5w8zD+1e7iTIuAHrWCGQG9lps407S9DjXeghppdLX3BpfbF
         fFkBoB+mczSxk55eVNIvtk6fXBlZ74nYEyeKL9R5gAaJcceZVtE+RyXGMmlV+cGmp2h4
         ypHrEwO1PPYn+zIotXZbaMvZFrSURUZt0OF/OlPITXLWJzEIuuOxNcaBOOq/bgg/QcHo
         ToXkrhv1EC4DAQQR6idtpJP3MfbF5XMt8ODN09+beYxofeOTeaajJNTQ+wDc0de9CU1t
         Nh6A==
X-Gm-Message-State: AOJu0YzHyAn/nmOcZGO/fbE3F8pgi4zyUhy8GidPcZ9N3iMsbK7kw+xQ
	GSuBUlNqfyAfMGggMSpdISU=
X-Google-Smtp-Source: AGHT+IE+occjyUfKXfdcE9LfYZNROlhM2rPi8sJfQ4ngTOZ2pBqecjThfZVJOgM9WVmmZG4pWtrJIw==
X-Received: by 2002:a5d:638f:0:b0:337:51d3:ba68 with SMTP id p15-20020a5d638f000000b0033751d3ba68mr38875wru.54.1704749451948;
        Mon, 08 Jan 2024 13:30:51 -0800 (PST)
Received: from [192.168.0.3] ([69.6.8.124])
        by smtp.gmail.com with ESMTPSA id c6-20020adfed86000000b00336751cd4ebsm624283wro.72.2024.01.08.13.30.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 08 Jan 2024 13:30:51 -0800 (PST)
Message-ID: <36c4f384-33aa-4662-81f3-0cd2ba8baa1b@gmail.com>
Date: Mon, 8 Jan 2024 23:30:48 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [net-next v3 3/3] net: wwan: t7xx: Add fastboot WWAN port
Content-Language: en-US
To: Jinjian Song <songjinjian@hotmail.com>
Cc: netdev@vger.kernel.org, chandrashekar.devegowda@intel.com,
 chiranjeevi.rapolu@linux.intel.com, haijun.liu@mediatek.com,
 m.chetan.kumar@linux.intel.com, ricardo.martinez@linux.intel.com,
 loic.poulain@linaro.org, johannes@sipsolutions.net, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 linux-kernel@vger.kernel.com, vsankar@lenovo.com, danielwinkler@google.com,
 nmarupaka@google.com, joey.zhao@fibocom.com, liuqf@fibocom.com,
 felix.yan@fibocom.com, Jinjian Song <jinjian.song@fibocom.com>
References: <20231228094411.13224-1-songjinjian@hotmail.com>
 <MEYP282MB2697BEA4E763368E567E909FBB9EA@MEYP282MB2697.AUSP282.PROD.OUTLOOK.COM>
From: Sergey Ryazanov <ryazanov.s.a@gmail.com>
In-Reply-To: <MEYP282MB2697BEA4E763368E567E909FBB9EA@MEYP282MB2697.AUSP282.PROD.OUTLOOK.COM>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hello Jinjian,

thank you for sharing this implementation. I believe this patch requires 
further splitting since its hard to distinguish between generic changes 
and fastboot port introduction. And here a lot of changes to the common 
driver codebase. At least the ports configuration rework worth a 
dedicated patch and probably modem boot state tracking also requires a 
dedicated patch or should go to the modem state exporting patch.

Please find a few nitpicks below.

On 28.12.2023 11:44, Jinjian Song wrote:

[skipped]

> @@ -82,6 +91,7 @@ struct cldma_queue {
>   	wait_queue_head_t req_wq;	/* Only for TX */
>   	struct workqueue_struct *worker;
>   	struct work_struct cldma_work;
> +	int (*recv_skb)(struct cldma_queue *queue, struct sk_buff *skb);
>   };
>   
>   struct cldma_ctrl {
> @@ -101,24 +111,22 @@ struct cldma_ctrl {
>   	struct md_pm_entity *pm_entity;
>   	struct t7xx_cldma_hw hw_info;
>   	bool is_late_init;
> -	int (*recv_skb)(struct cldma_queue *queue, struct sk_buff *skb);
>   };

What was the purpose of moving the recv_skb callback between layers?

[skipped]

> diff --git a/drivers/net/wwan/t7xx/t7xx_pci.c b/drivers/net/wwan/t7xx/t7xx_pci.c
> index d5f6a8638aba..f51e5e2b41e1 100644
> --- a/drivers/net/wwan/t7xx/t7xx_pci.c
> +++ b/drivers/net/wwan/t7xx/t7xx_pci.c
> @@ -170,7 +170,8 @@ static int t7xx_pci_pm_init(struct t7xx_pci_dev *t7xx_dev)
>   	pm_runtime_set_autosuspend_delay(&pdev->dev, PM_AUTOSUSPEND_MS);
>   	pm_runtime_use_autosuspend(&pdev->dev);
>   
> -	return t7xx_wait_pm_config(t7xx_dev);
> +	t7xx_wait_pm_config(t7xx_dev);
> +	return 0;

What was the purpose of breaking the error reporting?

>   }
>   
>   void t7xx_pci_pm_init_late(struct t7xx_pci_dev *t7xx_dev)
> diff --git a/drivers/net/wwan/t7xx/t7xx_port.h b/drivers/net/wwan/t7xx/t7xx_port.h
> index 4ae8a00a8532..09acb1ef144d 100644
> --- a/drivers/net/wwan/t7xx/t7xx_port.h
> +++ b/drivers/net/wwan/t7xx/t7xx_port.h
> @@ -75,6 +75,8 @@ enum port_ch {
>   	PORT_CH_DSS6_TX = 0x20df,
>   	PORT_CH_DSS7_RX = 0x20e0,
>   	PORT_CH_DSS7_TX = 0x20e1,
> +
> +	PORT_CH_ID_UNIMPORTANT = 0xffff,

Do we need this '_ID_' inside the name?

>   };

[skipped]

> +static int t7xx_port_ctrl_start(struct wwan_port *port)

Please use consistent prefixes, when it is possible. Half of objects 
below have 't7xx_port_fastboot_' not 't7xx_port_ctrl_' prefix. And this 
is t7xx_port_fastboot.c file, what make more sence for the former prefix.

[skipped]

> +static const struct wwan_port_ops wwan_ops = {

Should it be called t7xx_port_fastboot_ops?

> +	.start = t7xx_port_ctrl_start,
> +	.stop = t7xx_port_ctrl_stop,
> +	.tx = t7xx_port_ctrl_tx,
> +};

[skipped]

> +struct port_ops fastboot_port_ops = {
> +	.init = t7xx_port_fastboot_init,
> +	.recv_skb = t7xx_port_fastboot_recv_skb,
> +	.uninit = t7xx_port_fastboot_uninit,
> +	.enable_chl = t7xx_port_fastboot_enable_chl,
> +	.disable_chl = t7xx_port_fastboot_disable_chl,
> +};
> diff --git a/drivers/net/wwan/t7xx/t7xx_port_proxy.c b/drivers/net/wwan/t7xx/t7xx_port_proxy.c
> index 274846d39fbf..0525a70acc81 100644
> --- a/drivers/net/wwan/t7xx/t7xx_port_proxy.c
> +++ b/drivers/net/wwan/t7xx/t7xx_port_proxy.c
> @@ -100,6 +100,21 @@ static const struct t7xx_port_conf t7xx_port_conf[] = {
>   	},
>   };
>   
> +static struct t7xx_port_conf t7xx_early_port_conf[] = {

Seems this array should be a constant.

> +	{
> +		.tx_ch = PORT_CH_ID_UNIMPORTANT,
> +		.rx_ch = PORT_CH_ID_UNIMPORTANT,
> +		.txq_index = CLDMA_Q_IDX_DUMP,
> +		.rxq_index = CLDMA_Q_IDX_DUMP,
> +		.txq_exp_index = CLDMA_Q_IDX_DUMP,
> +		.rxq_exp_index = CLDMA_Q_IDX_DUMP,
> +		.path_id = CLDMA_ID_AP,
> +		.ops = &fastboot_port_ops,
> +		.name = "FASTBOOT",

Is FASTBOOT abbriviation? Why is it spelled in capital?

> +		.port_type = WWAN_PORT_FASTBOOT,
> +	},
> +};

[skipped]

>   static int t7xx_proxy_alloc(struct t7xx_modem *md)
>   {
> +	unsigned int early_port_count = ARRAY_SIZE(t7xx_early_port_conf);
>   	unsigned int port_count = ARRAY_SIZE(t7xx_port_conf);
>   	struct device *dev = &md->t7xx_dev->pdev->dev;
>   	struct port_proxy *port_prox;
> -	int i;
>   
> +	port_count = max(port_count, early_port_count);
>   	port_prox = devm_kzalloc(dev, sizeof(*port_prox) + sizeof(struct t7xx_port) * port_count,
>   				 GFP_KERNEL);

If you need just a maximum size of two sets of ports, then it is 
possible to achieve this with a macro:

#define T7XX_MAX_POSSIBLE_PORTS_NUM \
      (max(ARRAY_SIZE(t7xx_port_conf), ARRAY_SIZE(t7xx_early_port_conf)))

devm_kzalloc(dev, sizeof(*port_prox) +
              sizeof(struct t7xx_port) * T7XX_MAX_POSSIBLE_PORTS_NUM,
              GFP_KERNEL);

[skipped]

>   #define T7XX_PCIE_MISC_DEV_STATUS		0x0d1c
> -#define MISC_STAGE_MASK				GENMASK(2, 0)
> -#define MISC_RESET_TYPE_PLDR			BIT(26)
>   #define MISC_RESET_TYPE_FLDR			BIT(27)
> -#define LINUX_STAGE				4
> +#define MISC_RESET_TYPE_PLDR			BIT(26)
> +#define MISC_LK_EVENT_MASK			GENMASK(11, 8)
> +#define HOST_EVENT_MASK				GENMASK(31, 28)
> +
> +enum lk_event_id {
> +	LK_EVENT_NORMAL = 0,
> +	LK_EVENT_CREATE_PD_PORT = 1,
> +	LK_EVENT_CREATE_POST_DL_PORT = 2,
> +	LK_EVENT_RESET = 7,
> +};
> +
> +#define MISC_STAGE_MASK				GENMASK(2, 0)

Why does MISC_STAGE_MASK seems to be recreated? Some whitespace changes 
or just a git-diff glitch?

> +enum t7xx_device_stage {
> +	T7XX_DEV_STAGE_INIT = 0,
> +	T7XX_DEV_STAGE_BROM_PRE = 1,
> +	T7XX_DEV_STAGE_BROM_POST = 2,
> +	T7XX_DEV_STAGE_LK = 3,
> +	T7XX_DEV_STAGE_LINUX = 4,
> +};

[skipped]

> -	ret = read_poll_timeout(ioread32, dev_status,
> -				(dev_status & MISC_STAGE_MASK) == LINUX_STAGE, 20000, 2000000,
> -				false, IREG_BASE(md->t7xx_dev) + T7XX_PCIE_MISC_DEV_STATUS);
> +	ret = read_poll_timeout(ioread32, status,
> +				((status & MISC_STAGE_MASK) == T7XX_DEV_STAGE_LINUX) ||
> +				((status & MISC_STAGE_MASK) == T7XX_DEV_STAGE_LK), 100000,
> +				20000000, false, IREG_BASE(md->t7xx_dev) +
> +				T7XX_PCIE_MISC_DEV_STATUS);

Can it be (re-)wrapped in a more readable way? Or can we use a macro 
here to make it readable again?

[skipped]

> diff --git a/drivers/net/wwan/t7xx/t7xx_state_monitor.h b/drivers/net/wwan/t7xx/t7xx_state_monitor.h
> index b0b3662ae6d7..9421bbd2f117 100644
> --- a/drivers/net/wwan/t7xx/t7xx_state_monitor.h
> +++ b/drivers/net/wwan/t7xx/t7xx_state_monitor.h
> @@ -96,6 +96,7 @@ struct t7xx_fsm_ctl {
>   	bool			exp_flg;
>   	spinlock_t		notifier_lock;		/* Protects notifier list */
>   	struct list_head	notifier_list;
> +	u32                     prev_status;

Why is it called 'previous status' do we store 'current status' in the 
same structure?

--
Sergey

