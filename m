Return-Path: <netdev+bounces-56645-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 03B7E80FB71
	for <lists+netdev@lfdr.de>; Wed, 13 Dec 2023 00:34:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A685B1F21965
	for <lists+netdev@lfdr.de>; Tue, 12 Dec 2023 23:34:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3C6164CF0;
	Tue, 12 Dec 2023 23:34:48 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1FB2A0;
	Tue, 12 Dec 2023 15:34:45 -0800 (PST)
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-a1f653e3c3dso658307166b.2;
        Tue, 12 Dec 2023 15:34:45 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702424084; x=1703028884;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=g8BCH+XloJAoL2ErcgZHUuWCOYCoHswW23v2ajF1r/M=;
        b=IIQwjJ+fRH8gIN9VG18IAQhVzNI8V91OoLixl4/RIPQxQG9L1wMhvmZh3oFuNUHbLo
         VFKJkzjKRZZGjEdW60lzXgEfwMZj3iPt9O0o3IjUp8Y0Bq1hHU+VXHpzbaXkqi+WK39I
         F8alLf7rJVrl3zVcLwKuYf6JaBRPj2YAwMLdPE1n+Rh+OZ7i7kuKC/PUGcNNTGcRo0KB
         pFwM70yVmxxqnhNVyrjrIiRFhp7Sd5o1lPRl9l4uaw5IjBZ26b8MlUjWoBL4ugzmSsWk
         Kokq9hOpTMMADnwHqINqbaGoXtt5f1aNpTobtm/8pGLK1XOwO9jK0gTxidxMqJJopZQ2
         sqgw==
X-Gm-Message-State: AOJu0Yyx33GZekyIek+x7gCP7CjxgxPsF063KhZ320vSHrbP+Xvq+8ZO
	cn5/6pur3L6Um46jUXID90k=
X-Google-Smtp-Source: AGHT+IE+ZS50QN2cjpnHJfJ479Ioj5eP2Kok6/PKjUvIwARxSa4/9T0JV88vzgBuNRG2izHbz660TQ==
X-Received: by 2002:a17:906:bf41:b0:a1d:86c0:7be1 with SMTP id ps1-20020a170906bf4100b00a1d86c07be1mr1932105ejb.251.1702424083966;
        Tue, 12 Dec 2023 15:34:43 -0800 (PST)
Received: from gmail.com (fwdproxy-cln-021.fbsv.net. [2a03:2880:31ff:15::face:b00c])
        by smtp.gmail.com with ESMTPSA id rm6-20020a1709076b0600b00a1f6f120b33sm6409143ejc.110.2023.12.12.15.34.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Dec 2023 15:34:43 -0800 (PST)
Date: Tue, 12 Dec 2023 15:34:41 -0800
From: Breno Leitao <leitao@debian.org>
To: Donald Hunter <donald.hunter@gmail.com>
Cc: netdev@vger.kernel.org, Jakub Kicinski <kuba@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
	Jacob Keller <jacob.e.keller@intel.com>, donald.hunter@redhat.com
Subject: Re: [PATCH net-next v3 09/13] doc/netlink: Regenerate netlink .rst
 files if ynl-gen-rst changes
Message-ID: <ZXjuEUmXWRLMbj15@gmail.com>
References: <20231212221552.3622-1-donald.hunter@gmail.com>
 <20231212221552.3622-10-donald.hunter@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231212221552.3622-10-donald.hunter@gmail.com>

> +$(YNL_INDEX): $(YNL_RST_FILES) $(YNL_TOOL)
> +	$(Q)$(YNL_TOOL) -o $@ -x

Isn't $(YNL_INDEX) depending to $(YNL_TOOL) indirectly since it depends
on $(YNL_RST_FILES) ?

I mean, do you really need the line above?

> +$(YNL_RST_DIR)/%.rst: $(YNL_YAML_DIR)/%.yaml $(YNL_TOOL)
> +	$(Q)$(YNL_TOOL) -i $< -o $@

