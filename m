Return-Path: <netdev+bounces-37794-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 35CA37B734D
	for <lists+netdev@lfdr.de>; Tue,  3 Oct 2023 23:28:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by ny.mirrors.kernel.org (Postfix) with ESMTP id 4A0AE1C2048C
	for <lists+netdev@lfdr.de>; Tue,  3 Oct 2023 21:28:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69EAD3D972;
	Tue,  3 Oct 2023 21:28:01 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DA513CCF9
	for <netdev@vger.kernel.org>; Tue,  3 Oct 2023 21:27:59 +0000 (UTC)
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A294283;
	Tue,  3 Oct 2023 14:27:58 -0700 (PDT)
Received: by mail-ed1-x52c.google.com with SMTP id 4fb4d7f45d1cf-533d9925094so2402639a12.2;
        Tue, 03 Oct 2023 14:27:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696368477; x=1696973277; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=ZGGKd+eyOpaAhJP41rJ87nk9mJ2Zml+/YtCwN7Pz7js=;
        b=idcsbi8coXQ3A4DB5GTcq0HKS7Pfyfu9L1oVDRQN8xNelTH+zX96czBLcSws+29UIk
         yq4yUrfxm66NqghJY6USSUwBQLqVFx5f365q3+zofl+rE/hDw4Nnv1DiCl/qfZD9bha1
         J+D8JluRgkRMXm3ZItpcz1f6YrSkSokfitiw5hu1l2XeodyhZsE8n2yNiIisUnALud8B
         uSWVyBpIy8eVrPs95haz5dCV53v8cSPuDrh4UN8MccxxFhHcdxhU09TdYpwuzu80UHPy
         2ERWe9rPSnbLQo/tXWfw4w3/ofzkv4mqHCsaqtOuChaBHtO0DyXq0+G4uJXCXr1YoakF
         6vIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696368477; x=1696973277;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZGGKd+eyOpaAhJP41rJ87nk9mJ2Zml+/YtCwN7Pz7js=;
        b=tIM0u012G5f73ptBkNprTNwbG15SVSooeMPQ9bzRVSMWyAsHtfCK8ZUcIcEAA1mVa/
         /xBdwXH1q0Aq9tfanFxL1NET6P8DceFDrf/VdxVQt4puKrvfTMtjL78pf20XK6biYAYX
         7PNKBj/y3LGClLaUGS+BCmIz3pwoFbFYVT6xyGv0rKAfUGbQ5D68cWesKzJ7G/opzyC0
         Ph2fgJEBWQdp1sn/SgfVHC01bJbodf7MsG4mCvrLD5qaH+tVnkC67j3Cm+cLKc0GewT8
         lmUsdGtQmIYvqmvi/VTg4FclpO5u3sWIlqbZ1p8oiRQMC5bh/3ZUVJcsdK+/I+x3zOKr
         JtTg==
X-Gm-Message-State: AOJu0YwxXEgFy3qpCD22f8KlQAIQN5eeMkzTGr8GQWx1hoFneydqo1L0
	iVJu/XX3chl5x0Kg3JwB6CS4mmshRDI=
X-Google-Smtp-Source: AGHT+IHScfXIdYBQZ6OVobhMNrSXcR0ZU9JnpEPW/9pjyPhJA/VLiXYTgGpPNDpxvx7cUw+e1HHiXA==
X-Received: by 2002:a05:6402:1219:b0:530:77e6:849f with SMTP id c25-20020a056402121900b0053077e6849fmr336413edw.27.1696368476922;
        Tue, 03 Oct 2023 14:27:56 -0700 (PDT)
Received: from skbuf ([188.25.255.218])
        by smtp.gmail.com with ESMTPSA id c11-20020aa7df0b000000b00533dd4d2947sm1414737edy.74.2023.10.03.14.27.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Oct 2023 14:27:56 -0700 (PDT)
Date: Wed, 4 Oct 2023 00:27:54 +0300
From: Vladimir Oltean <olteanv@gmail.com>
To: =?utf-8?B?UGF3ZcWC?= Dembicki <paweldembicki@gmail.com>
Cc: netdev@vger.kernel.org, Dan Carpenter <dan.carpenter@linaro.org>,
	Simon Horman <simon.horman@corigine.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Florian Fainelli <f.fainelli@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Russell King <linux@armlinux.org.uk>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v3 5/8] net: dsa: vsc73xx: Add vlan filtering
Message-ID: <20231003212754.bbel76726dqyrtyn@skbuf>
References: <20230912122201.3752918-1-paweldembicki@gmail.com>
 <20230912122201.3752918-6-paweldembicki@gmail.com>
 <20230912161709.g34slexfaop6xp7w@skbuf>
 <CAJN1Kkwzwt++6GtrAnCbKzYto-uQECYZz5=N7bePqK9wsK2_+g@mail.gmail.com>
 <20230926235848.3uftpkj7m24qsord@skbuf>
 <CAJN1KkxcPzQ3-KCPdh1N6CGg7Foj=JbP3b2Kg=vqxpKOZumn8w@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJN1KkxcPzQ3-KCPdh1N6CGg7Foj=JbP3b2Kg=vqxpKOZumn8w@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Tue, Oct 03, 2023 at 11:14:55PM +0200, Paweł Dembicki wrote:
> Should I make a local copy of the quantity of egress untagged and
> tagged vlans per port to resolve this issue, shouldn't I?
> And then I check how many vlans are egress tagged or untagged for a
> properly restricted solution?

Yeah, I guess so. It is the same problem that ocelot_vlan_prepare()
tries to solve, and that counts ocelot_port_num_untagged_vlans() and
ocelot_port_num_tagged_vlans() indeed.

> I see another problem. Even if I return an error value, the untagged
> will be marked in 'bridge vlan' listing. I'm not sure how it should
> work in this case.

What error code are you returning, -EOPNOTSUPP I guess? That's
deliberately ignored by callers of br_switchdev_port_vlan_add(), because
it means "no one responded to the switchdev notifier, so the VLAN is not
offloaded". If you want to deny the configuration you need to return
something else, like -EBUSY.

