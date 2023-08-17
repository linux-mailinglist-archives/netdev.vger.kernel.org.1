Return-Path: <netdev+bounces-28370-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C3CA277F31B
	for <lists+netdev@lfdr.de>; Thu, 17 Aug 2023 11:20:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 03180281E00
	for <lists+netdev@lfdr.de>; Thu, 17 Aug 2023 09:20:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 900D111CBF;
	Thu, 17 Aug 2023 09:20:45 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E1823C10
	for <netdev@vger.kernel.org>; Thu, 17 Aug 2023 09:20:45 +0000 (UTC)
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EDB52271B
	for <netdev@vger.kernel.org>; Thu, 17 Aug 2023 02:20:42 -0700 (PDT)
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-523029050d0so1900581a12.0
        for <netdev@vger.kernel.org>; Thu, 17 Aug 2023 02:20:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692264041; x=1692868841;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=IIebZwojAKXZwO37JWETlKiaDFkVEjvbBEdVxz873MI=;
        b=CpMh+mbRv7tVz18MSS2lUqn54kCCBcGu3YmiGmZmZcEKi4VI1UfI8hEK5o/T0Tg7nl
         b0JTXqzYny9VuO2nMPvCW1sSdyixdl9mTnzoUdjSHRDoerFtIrVqsAiZVb/iQzOZ7LTX
         Vk1yWDI+Nc36epcn9tTl6rpLbU8NVOjp5ztpbJTPUKE2rtwm2pRorgAltvgh4oNUouK4
         gybNSTzTS/DTvO6lGm8mM+lVb4G9VNTNSFOTSOzUopuAc9wxaYFvFZU4SFBwd0I+io1y
         2Vdz+NclqzbGP/ClSJbvhJt8+VwDbiYqrjAGJ0/X1CPXsm0GXHlWtNzoNM2EFoUF0QY2
         NFeA==
X-Gm-Message-State: AOJu0YxCGDTaqsgtbjTIJDh8ZKnZfBlsZs+6qz1mKFWLx/TEg8Ph92cO
	ttwkeCt4Y6kWd7iRDpO8X24=
X-Google-Smtp-Source: AGHT+IEr+1KO7wYR0yvfbMijYLcyIbVVOH2d3phvgYskk0bC3zzyzjxbQBixVT3Ft7NzxOgP749uFw==
X-Received: by 2002:a17:906:1d8:b0:99d:ddae:f75d with SMTP id 24-20020a17090601d800b0099dddaef75dmr3166894ejj.4.1692264041185;
        Thu, 17 Aug 2023 02:20:41 -0700 (PDT)
Received: from [192.168.64.157] (bzq-219-42-90.isdn.bezeqint.net. [62.219.42.90])
        by smtp.gmail.com with ESMTPSA id kk9-20020a170907766900b0099cc36c4681sm9797768ejc.157.2023.08.17.02.20.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 17 Aug 2023 02:20:40 -0700 (PDT)
Message-ID: <f250deb1-90d9-f9c4-667f-9e6ad580cb6b@grimberg.me>
Date: Thu, 17 Aug 2023 12:20:38 +0300
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 11/18] nvme-fabrics: parse options 'keyring' and 'tls_key'
Content-Language: en-US
To: Hannes Reinecke <hare@suse.de>, Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <kbusch@kernel.org>, linux-nvme@lists.infradead.org,
 Jakub Kicinski <kuba@kernel.org>, Eric Dumazet <edumazet@google.com>,
 Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org
References: <20230816120608.37135-1-hare@suse.de>
 <20230816120608.37135-12-hare@suse.de>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20230816120608.37135-12-hare@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net



On 8/16/23 15:06, Hannes Reinecke wrote:
> Parse the fabrics options 'keyring' and 'tls_key' and store the
> referenced keys in the options structure.
> 
> Signed-off-by: Hannes Reinecke <hare@suse.de>
> Reviewed-by: Sagi Grimberg <sagi@grimberg.me>
> ---
>   drivers/nvme/host/fabrics.c | 52 ++++++++++++++++++++++++++++++++++++-
>   drivers/nvme/host/fabrics.h |  6 +++++
>   drivers/nvme/host/tcp.c     | 14 +++++++---
>   3 files changed, 67 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/nvme/host/fabrics.c b/drivers/nvme/host/fabrics.c
> index ddad482c3537..e453c3871cb1 100644
> --- a/drivers/nvme/host/fabrics.c
> +++ b/drivers/nvme/host/fabrics.c
> @@ -622,6 +622,23 @@ static struct nvmf_transport_ops *nvmf_lookup_transport(
>   	return NULL;
>   }
>   
> +static struct key *nvmf_parse_key(int key_id, char *key_type)
> +{
> +	struct key *key;
> +
> +	if (!IS_ENABLED(CONFIG_NVME_TCP_TLS)) {
> +		pr_err("TLS is not supported\n");
> +		return ERR_PTR(-EINVAL);
> +	}
> +
> +	key = key_lookup(key_id);
> +	if (IS_ERR(key))
> +		pr_err("%s %08x not found\n", key_type, key_id);
> +	else
> +		pr_debug("Using %s %08x\n", key_type, key_id);

I think that the key_type string is unneeded as an argument solely for
the log print.

I think that you can move the error print to the call-site. Keep
the debug print here, but you don't need the type...

> +	return key;
> +}
> +
>   static const match_table_t opt_tokens = {
>   	{ NVMF_OPT_TRANSPORT,		"transport=%s"		},
>   	{ NVMF_OPT_TRADDR,		"traddr=%s"		},
> @@ -643,6 +660,10 @@ static const match_table_t opt_tokens = {
>   	{ NVMF_OPT_NR_WRITE_QUEUES,	"nr_write_queues=%d"	},
>   	{ NVMF_OPT_NR_POLL_QUEUES,	"nr_poll_queues=%d"	},
>   	{ NVMF_OPT_TOS,			"tos=%d"		},
> +#ifdef CONFIG_NVME_TCP_TLS
> +	{ NVMF_OPT_KEYRING,		"keyring=%d"		},
> +	{ NVMF_OPT_TLS_KEY,		"tls_key=%d"		},
> +#endif
>   	{ NVMF_OPT_FAIL_FAST_TMO,	"fast_io_fail_tmo=%d"	},
>   	{ NVMF_OPT_DISCOVERY,		"discovery"		},
>   	{ NVMF_OPT_DHCHAP_SECRET,	"dhchap_secret=%s"	},
> @@ -660,9 +681,10 @@ static int nvmf_parse_options(struct nvmf_ctrl_options *opts,
>   	char *options, *o, *p;
>   	int token, ret = 0;
>   	size_t nqnlen  = 0;
> -	int ctrl_loss_tmo = NVMF_DEF_CTRL_LOSS_TMO;
> +	int ctrl_loss_tmo = NVMF_DEF_CTRL_LOSS_TMO, key_id;
>   	uuid_t hostid;
>   	char hostnqn[NVMF_NQN_SIZE];
> +	struct key *key;
>   
>   	/* Set defaults */
>   	opts->queue_size = NVMF_DEF_QUEUE_SIZE;
> @@ -928,6 +950,32 @@ static int nvmf_parse_options(struct nvmf_ctrl_options *opts,
>   			}
>   			opts->tos = token;
>   			break;
> +		case NVMF_OPT_KEYRING:
> +			if (match_int(args, &key_id) || key_id <= 0) {
> +				ret = -EINVAL;
> +				goto out;
> +			}
> +			key = nvmf_parse_key(key_id, "Keyring");
> +			if (IS_ERR(key)) {
> +				ret = PTR_ERR(key);
> +				goto out;
> +			}
> +			key_put(opts->keyring);

Don't understand how keyring/tls_key are pre-populated though...

> +			opts->keyring = key;
> +			break;
> +		case NVMF_OPT_TLS_KEY:
> +			if (match_int(args, &key_id) || key_id <= 0) {
> +				ret = -EINVAL;
> +				goto out;
> +			}
> +			key = nvmf_parse_key(key_id, "Key");
> +			if (IS_ERR(key)) {
> +				ret = PTR_ERR(key);
> +				goto out;
> +			}
> +			key_put(opts->tls_key);
> +			opts->tls_key = key;
> +			break;
>   		case NVMF_OPT_DISCOVERY:
>   			opts->discovery_nqn = true;
>   			break;
> @@ -1168,6 +1216,8 @@ static int nvmf_check_allowed_opts(struct nvmf_ctrl_options *opts,
>   void nvmf_free_options(struct nvmf_ctrl_options *opts)
>   {
>   	nvmf_host_put(opts->host);
> +	key_put(opts->keyring);
> +	key_put(opts->tls_key);
>   	kfree(opts->transport);
>   	kfree(opts->traddr);
>   	kfree(opts->trsvcid);
> diff --git a/drivers/nvme/host/fabrics.h b/drivers/nvme/host/fabrics.h
> index dac17c3fee26..fbaee5a7be19 100644
> --- a/drivers/nvme/host/fabrics.h
> +++ b/drivers/nvme/host/fabrics.h
> @@ -71,6 +71,8 @@ enum {
>   	NVMF_OPT_DHCHAP_SECRET	= 1 << 23,
>   	NVMF_OPT_DHCHAP_CTRL_SECRET = 1 << 24,
>   	NVMF_OPT_TLS		= 1 << 25,
> +	NVMF_OPT_KEYRING	= 1 << 26,
> +	NVMF_OPT_TLS_KEY	= 1 << 27,
>   };
>   
>   /**
> @@ -103,6 +105,8 @@ enum {
>    * @dhchap_secret: DH-HMAC-CHAP secret
>    * @dhchap_ctrl_secret: DH-HMAC-CHAP controller secret for bi-directional
>    *              authentication
> + * @keyring:    Keyring to use for key lookups
> + * @tls_key:    TLS key for encrypted connections (TCP)
>    * @tls:        Start TLS encrypted connections (TCP)
>    * @disable_sqflow: disable controller sq flow control
>    * @hdr_digest: generate/verify header digest (TCP)
> @@ -130,6 +134,8 @@ struct nvmf_ctrl_options {
>   	struct nvmf_host	*host;
>   	char			*dhchap_secret;
>   	char			*dhchap_ctrl_secret;
> +	struct key		*keyring;
> +	struct key		*tls_key;
>   	bool			tls;
>   	bool			disable_sqflow;
>   	bool			hdr_digest;
> diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
> index ef9cf8c7a113..f48797fcc4ee 100644
> --- a/drivers/nvme/host/tcp.c
> +++ b/drivers/nvme/host/tcp.c
> @@ -1589,6 +1589,8 @@ static int nvme_tcp_start_tls(struct nvme_ctrl *nctrl,
>   
>   	dev_dbg(nctrl->device, "queue %d: start TLS with key %x\n",
>   		qid, pskid);
> +	if (nctrl->opts->keyring)
> +		keyring = key_serial(nctrl->opts->keyring);

Maybe populate opts->keyring with nvme_keyring_id() to begin
with and then you don't need this?

>   	memset(&args, 0, sizeof(args));
>   	args.ta_sock = queue->sock;
>   	args.ta_done = nvme_tcp_tls_done;
> @@ -1914,9 +1916,12 @@ static int nvme_tcp_alloc_admin_queue(struct nvme_ctrl *ctrl)
>   	key_serial_t pskid = 0;
>   
>   	if (ctrl->opts->tls) {
> -		pskid = nvme_tls_psk_default(NULL,
> -					      ctrl->opts->host->nqn,
> -					      ctrl->opts->subsysnqn);
> +		if (ctrl->opts->tls_key)
> +			pskid = key_serial(ctrl->opts->tls_key);
> +		else
> +			pskid = nvme_tls_psk_default(ctrl->opts->keyring,
> +						      ctrl->opts->host->nqn,
> +						      ctrl->opts->subsysnqn);
>   		if (!pskid) {
>   			dev_err(ctrl->device, "no valid PSK found\n");
>   			ret = -ENOKEY;
> @@ -2776,7 +2781,8 @@ static struct nvmf_transport_ops nvme_tcp_transport = {
>   			  NVMF_OPT_HOST_TRADDR | NVMF_OPT_CTRL_LOSS_TMO |
>   			  NVMF_OPT_HDR_DIGEST | NVMF_OPT_DATA_DIGEST |
>   			  NVMF_OPT_NR_WRITE_QUEUES | NVMF_OPT_NR_POLL_QUEUES |
> -			  NVMF_OPT_TOS | NVMF_OPT_HOST_IFACE | NVMF_OPT_TLS,
> +			  NVMF_OPT_TOS | NVMF_OPT_HOST_IFACE | NVMF_OPT_TLS |
> +			  NVMF_OPT_KEYRING | NVMF_OPT_TLS_KEY,
>   	.create_ctrl	= nvme_tcp_create_ctrl,
>   };
>   

