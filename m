Return-Path: <netdev+bounces-56590-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1691280F802
	for <lists+netdev@lfdr.de>; Tue, 12 Dec 2023 21:39:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B3C8F1F214EA
	for <lists+netdev@lfdr.de>; Tue, 12 Dec 2023 20:39:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7291D6412E;
	Tue, 12 Dec 2023 20:39:48 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5926BC;
	Tue, 12 Dec 2023 12:39:41 -0800 (PST)
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-a1f5cb80a91so665107566b.3;
        Tue, 12 Dec 2023 12:39:41 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702413580; x=1703018380;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Go6fvDPmFCdEym2r9IELET0hUv2nxIIQ4R4i+BuwgG0=;
        b=aTGu9S7ZOTASvwv1kuy2O9ExDx3sDHggfoqgi9O+vwb4s9r9M3bT/6aOONoulBUpdm
         O5zK2G85fCE8Uqhu0hTfwgCRZrETmVnhPNHVmiofILn4rHUIQeXQ18VxYYh/Mcyg966E
         yPUBcphMRM7OTCh0HPX6IvX2i5vLVtlkS+fnnlGO4FG459iyXoox+HPYevDjxaiLHdQE
         vFdblyydPFTM4lwjgcZ7Oe+k3fjNlI5AKFRxII+Ewt4JJsLjt7hbn107qu9z6qnyEeZj
         RctyVcrDKiBMvtVXRKrwmEA9mHSDyUa48uJF1hronoTfhdHr6xQu9If7CJ2oZN5A88XB
         AtHA==
X-Gm-Message-State: AOJu0Yz8od6EOf9gHpTN6gIiUq8AfyJekAJ28CGcFnemKeoHMs+5hHJ3
	9vZ8913NylrPyzO0vexWQwM=
X-Google-Smtp-Source: AGHT+IE2kJyLwALQrYrxatA2e5XPjGxAzOJyuIz/sUEcYn9PsHck8cNEBndbF6mmhjVn57sXFAPGeQ==
X-Received: by 2002:a17:907:d15:b0:a1a:582d:f0e9 with SMTP id gn21-20020a1709070d1500b00a1a582df0e9mr2583209ejc.73.1702413580017;
        Tue, 12 Dec 2023 12:39:40 -0800 (PST)
Received: from gmail.com (fwdproxy-cln-025.fbsv.net. [2a03:2880:31ff:19::face:b00c])
        by smtp.gmail.com with ESMTPSA id rf22-20020a1709076a1600b00a1d0b15f634sm6673271ejc.76.2023.12.12.12.39.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Dec 2023 12:39:39 -0800 (PST)
Date: Tue, 12 Dec 2023 12:39:35 -0800
From: Breno Leitao <leitao@debian.org>
To: Donald Hunter <donald.hunter@gmail.com>
Cc: netdev@vger.kernel.org, Jakub Kicinski <kuba@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
	Jacob Keller <jacob.e.keller@intel.com>, donald.hunter@redhat.com
Subject: Re: [PATCH net-next v2 03/11] doc/netlink: Regenerate netlink .rst
 files if ynl-gen-rst changes
Message-ID: <ZXjFB90lpIQqbFtE@gmail.com>
References: <20231211164039.83034-1-donald.hunter@gmail.com>
 <20231211164039.83034-4-donald.hunter@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231211164039.83034-4-donald.hunter@gmail.com>

On Mon, Dec 11, 2023 at 04:40:31PM +0000, Donald Hunter wrote:
> Add ynl-gen-rst.py to the dependencies for the netlink .rst files in the
> doc Makefile so that the docs get regenerated if the ynl-gen-rst.py
> script is modified.
> 
> Signed-off-by: Donald Hunter <donald.hunter@gmail.com>
> ---
>  Documentation/Makefile | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)
> 
> diff --git a/Documentation/Makefile b/Documentation/Makefile
> index 5c156fbb6cdf..9a31625ea1ff 100644
> --- a/Documentation/Makefile
> +++ b/Documentation/Makefile
> @@ -105,11 +105,12 @@ YNL_TOOL:=$(srctree)/tools/net/ynl/ynl-gen-rst.py
>  YNL_RST_FILES_TMP := $(patsubst %.yaml,%.rst,$(wildcard $(YNL_YAML_DIR)/*.yaml))
>  YNL_RST_FILES := $(patsubst $(YNL_YAML_DIR)%,$(YNL_RST_DIR)%, $(YNL_RST_FILES_TMP))
>  
> -$(YNL_INDEX): $(YNL_RST_FILES)
> +$(YNL_INDEX): $(YNL_RST_FILES) $(YNL_TOOL)
>  	@$(YNL_TOOL) -o $@ -x
>  
> -$(YNL_RST_DIR)/%.rst: $(YNL_YAML_DIR)/%.yaml
> -	@$(YNL_TOOL) -i $< -o $@

> +$(YNL_RST_DIR)/%.rst: $(YNL_TOOL)
> +$(YNL_RST_DIR)/%.rst: $(YNL_YAML_DIR)/%.yaml $(YNL_TOOL)
> +	$(YNL_TOOL) -i $< -o $@

Why do you need both lines here? Isn't the last line enough?

	$(YNL_RST_DIR)/%.rst: $(YNL_YAML_DIR)/%.yaml $(YNL_TOOL)

