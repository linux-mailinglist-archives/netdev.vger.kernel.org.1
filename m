Return-Path: <netdev+bounces-36380-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A1CD7AF70F
	for <lists+netdev@lfdr.de>; Wed, 27 Sep 2023 02:11:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by ny.mirrors.kernel.org (Postfix) with ESMTP id F2D601C2089B
	for <lists+netdev@lfdr.de>; Wed, 27 Sep 2023 00:11:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A32AC620;
	Wed, 27 Sep 2023 00:11:12 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36978197
	for <netdev@vger.kernel.org>; Wed, 27 Sep 2023 00:11:11 +0000 (UTC)
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 975304481;
	Tue, 26 Sep 2023 17:11:08 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id a640c23a62f3a-9a6190af24aso1224358066b.0;
        Tue, 26 Sep 2023 17:11:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695773466; x=1696378266; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=0cejTfsMXE2dEylQFA8yefq6BkmENo/ye2ggxUf0b/I=;
        b=LDvDrI3De/WpDynWAjWPBly3sX/NBjxdDl6UaBP+DIsayp312D+VdAKfJw/qnZQ6KO
         goBmCfl9kiIX8cSV0RiiRiszZJGOajEH6BuEqkjr12GmvQy0qpQ6XN+qzKx9JcTeyK/p
         mPp47AUSG5LVMsB2uyEcR7PNWorol7PvWv9yE/4mDwTuvlLZLVUxpQ2CcBUmfFBe/KZv
         jWpzO57q19fX1eEP1vYo9DgaqqcH3mvGLM8euJsuaCUfAIz/tqmofEFfuR3/XbK7otbJ
         rv/RtiwM0il5H2+IHME5KLTxHBiH293BBJPt8EP16QU+HCMmTGuSGjXIs6Gje/crQM2P
         kwWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695773466; x=1696378266;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0cejTfsMXE2dEylQFA8yefq6BkmENo/ye2ggxUf0b/I=;
        b=Un8cMpSPxsslajRqiRePLvz0FDeACGkTXHshdSoug4zyOUrkKVLSvWr7LDXbV8mxNb
         YYILHaI4ObeqN7NyQUSHi9t6Pf9DT8W0mlI3MinGMPp1YEz1gzXItI7CFwEKnLbZasEO
         gWiRq+R2tTegIdBQdQdT/AMmH5epbWIkZP6krM2INIuEqL3HvcLO0nP5lcKskXr+xOfB
         Tpoxf6i7xFs8MuM+yQW36g+i6f46ETcAi9d8rVkq8yKy3ZbKQugttXsUkgA7TXTzqMtU
         H2Rm/LUwSv1JzVjBSiNUpHzYEo6lnhS59sn8oZVWBpmDvF8DtXvK7IQd7lWbIJ/UkJQY
         IAzQ==
X-Gm-Message-State: AOJu0YynAtx8/URBfjcwuMe4BMuhMbAHeL6MvQqWQgiRdJ9qh98gNIPa
	6KnhS+eijXXXZDXMFr9lRtM=
X-Google-Smtp-Source: AGHT+IFYWNj9ANgPsTKobtNhhcUsdEnpsJUVbWr7pPY1Do7b1A7P+c0bvOYTRVj91WTSGAin0COoMw==
X-Received: by 2002:a17:906:308a:b0:9b2:89ec:7fca with SMTP id 10-20020a170906308a00b009b289ec7fcamr224555ejv.34.1695773466352;
        Tue, 26 Sep 2023 17:11:06 -0700 (PDT)
Received: from skbuf ([188.25.161.12])
        by smtp.gmail.com with ESMTPSA id jx10-20020a170906ca4a00b009ad87d1be17sm8309656ejb.22.2023.09.26.17.11.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Sep 2023 17:11:06 -0700 (PDT)
Date: Wed, 27 Sep 2023 03:11:03 +0300
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
Subject: Re: [PATCH net-next v3 6/8] net: dsa: vsc73xx: introduce tag 8021q
 for vsc73xx
Message-ID: <20230927001103.5qgrwishmnxkyaul@skbuf>
References: <20230912122201.3752918-1-paweldembicki@gmail.com>
 <20230912122201.3752918-7-paweldembicki@gmail.com>
 <20230912213937.wqwiex32ojlojnue@skbuf>
 <CAJN1KkyV_B4Dhd65WmeetE8ynf+w=_L3XqE55=4+QWNLNRaDsQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJN1KkyV_B4Dhd65WmeetE8ynf+w=_L3XqE55=4+QWNLNRaDsQ@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Mon, Sep 25, 2023 at 10:55:29PM +0200, Paweł Dembicki wrote:
> > I've prepared some (only compile-tested) patches on this branch here:
> > https://github.com/vladimiroltean/linux/commits/pawel-dembicki-vsc73xx-v3
> >
> > I need to double-check that they don't introduce regressions,
> 
> I tested it on my device and I couldn't find any regressions. vlan
> filtering and tagging work as expected.

Thanks for testing. Obviously I still haven't :-/ Please feel free to
post the next version and I'll try to find some time to test.

> > and we
> > should discuss the merging strategy. Probably you're going to submit
> > them together with your patch set.
> 
> I prepared the v4 patch series. Please look if that format is ok with you.
> https://github.com/CHKDSK88/linux/commits/vsc73xx-vlan-net-next

I still have some style nitpicks similar to the ones expressed already,
but it isn't trivial for me to leave them through Github, so you can
post your best attempt at v4. You should also try to add a comment
explaining what's the reason for the special case for "if (port !=
CPU_PORT)" in vsc73xx_port_vlan_add().

