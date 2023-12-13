Return-Path: <netdev+bounces-56916-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E0A6811561
	for <lists+netdev@lfdr.de>; Wed, 13 Dec 2023 15:58:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C8601B20E21
	for <lists+netdev@lfdr.de>; Wed, 13 Dec 2023 14:58:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A70E2F505;
	Wed, 13 Dec 2023 14:58:17 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C033993;
	Wed, 13 Dec 2023 06:58:14 -0800 (PST)
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-a22f59c6ae6so131733066b.1;
        Wed, 13 Dec 2023 06:58:14 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702479493; x=1703084293;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UrW/rj920wP3mXyJWOJYlEt9EjV/7lSyDAH0JGYHXqc=;
        b=iz923m0erafDMWOhiovM9tV1V00MEljYSfuX45tTBxBgmdhluysVm5jVBhul6u3MS/
         k9pUKWNLCcU1W9w00F0A72RPcarzpgLshQ5w5QCRy+4Zk3vZt4FGe8OHNfif6yrRypdf
         9D1t+hKQNxchLT9iSq4qpn9b5EHWCKUN3o7sTFp8vffqs7q0fpijTz3SO5O7nwuiZS5G
         NMbewYpw5kFPKvnVxbBNe7QSKTwX1to5WT3bbmwrG2Jzj6Gwzujln/9WK4Xfv2efChNX
         Dn+L4/nwaghua3czCYv5PhgfnKCXQTErbWB4C3S0kiLG3rZZ3+itzZykLwJ960KEfwht
         PEeA==
X-Gm-Message-State: AOJu0YxXVZtna5CPkPX49sL/03/c3N8Hdnl7Egn3rXygTytH37R4QAxc
	bhkhdxULdtQ1NaEvPgTVU9k=
X-Google-Smtp-Source: AGHT+IHaaX+hfVBMBVoz+cKiEdYqOpt84eJjQ5cEU4s3iwVwzFqvV/cru2d7SHbeF/3mSNAVa/l8Uw==
X-Received: by 2002:a17:907:9403:b0:a1f:6707:cffc with SMTP id dk3-20020a170907940300b00a1f6707cffcmr2702351ejc.74.1702479492977;
        Wed, 13 Dec 2023 06:58:12 -0800 (PST)
Received: from gmail.com (fwdproxy-cln-117.fbsv.net. [2a03:2880:31ff:75::face:b00c])
        by smtp.gmail.com with ESMTPSA id vt5-20020a170907a60500b00a1d38589c67sm7984551ejc.98.2023.12.13.06.58.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Dec 2023 06:58:12 -0800 (PST)
Date: Wed, 13 Dec 2023 06:58:10 -0800
From: Breno Leitao <leitao@debian.org>
To: Donald Hunter <donald.hunter@gmail.com>
Cc: netdev@vger.kernel.org, Jakub Kicinski <kuba@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
	Jacob Keller <jacob.e.keller@intel.com>, donald.hunter@redhat.com
Subject: Re: [PATCH net-next v3 09/13] doc/netlink: Regenerate netlink .rst
 files if ynl-gen-rst changes
Message-ID: <ZXnGglqz01BxAB21@gmail.com>
References: <20231212221552.3622-1-donald.hunter@gmail.com>
 <20231212221552.3622-10-donald.hunter@gmail.com>
 <ZXjuEUmXWRLMbj15@gmail.com>
 <m21qbq780z.fsf@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <m21qbq780z.fsf@gmail.com>

On Wed, Dec 13, 2023 at 09:42:52AM +0000, Donald Hunter wrote:
> Breno Leitao <leitao@debian.org> writes:
> 
> >> +$(YNL_INDEX): $(YNL_RST_FILES) $(YNL_TOOL)
> >> +	$(Q)$(YNL_TOOL) -o $@ -x
> >
> > Isn't $(YNL_INDEX) depending to $(YNL_TOOL) indirectly since it depends
> > on $(YNL_RST_FILES) ?
> >
> > I mean, do you really need the line above?
> 
> Sure, the transitive dependency is sufficient. I tend to add an explicit
> dependency for a script that gets run in a target.
> 
> Happy to remove that change and respin if you prefer?

I would say it is preferred to remove unnecessary code.

Feel free to add the following line in the new version:

	Reviewed-by: Breno Leitao <leitao@debian.org>

Thanks for addressing this.

