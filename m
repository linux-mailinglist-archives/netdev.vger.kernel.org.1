Return-Path: <netdev+bounces-23194-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C61ED76B4A9
	for <lists+netdev@lfdr.de>; Tue,  1 Aug 2023 14:23:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 023C61C20E96
	for <lists+netdev@lfdr.de>; Tue,  1 Aug 2023 12:23:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9451A21506;
	Tue,  1 Aug 2023 12:23:34 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 867241F952
	for <netdev@vger.kernel.org>; Tue,  1 Aug 2023 12:23:34 +0000 (UTC)
Received: from mail-lj1-x22b.google.com (mail-lj1-x22b.google.com [IPv6:2a00:1450:4864:20::22b])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A3561FD6
	for <netdev@vger.kernel.org>; Tue,  1 Aug 2023 05:23:30 -0700 (PDT)
Received: by mail-lj1-x22b.google.com with SMTP id 38308e7fff4ca-2b9c55e0fbeso78864401fa.2
        for <netdev@vger.kernel.org>; Tue, 01 Aug 2023 05:23:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20221208.gappssmtp.com; s=20221208; t=1690892609; x=1691497409;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=3dKKb8ls1yAP3+3mMQaiILbL8e0BLGeeP71QwTnllps=;
        b=DkC0mBvOrKncTR0k7i72XDXDqoiXnY5ESHrTxvblfT+XNNur60TNYc0Eu8RO3om33H
         dyIhrfT/uhhl6ep/jzS4FuRLnjsNK4XunT+VmqruJLEKbscR9sAn6PbhEhM9Ugf8jwUB
         y46izYudAlIV4wvT/BChT8Xg6Cl2TMQoLaxj3IwocqY0Uj8XWtE+lmK1jnWrLnIqOMit
         VGhdwPJTHBa4TEWcfBZqUoyFlr+Uj38ZcFHCpEnGfrG3VI32dTQpl3/PwCEA1Fx/M707
         dNPeHcGmcXMphSO4fiSpc9Z3/Rb7/nCyvqYJKYofitaY6MEtoHrAr/bsaighbpJh5u3T
         SymA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690892609; x=1691497409;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3dKKb8ls1yAP3+3mMQaiILbL8e0BLGeeP71QwTnllps=;
        b=V0xde08ENdEhaYGMiVtR36Zk+A+KECS3tEwVcP3vRPTq6YC+ypS+E3ZqP+PPGI7W1O
         d54zL8gyqVThIPQFXyy41MCQKioOFDHh8+jrL2kYpdZnANLyh3Ku0fcA4SJOvm139pWS
         xXLMcXayYsg1VFOBnk5SDcPAjUUmQWFlC4jhVvwMFpsNvSZNuT4iTu+d5A6mLDnP4xK4
         D05g6ciwciAS3Zk4k5gG4M0+lS/q5SiRbqxJrNrfnQ18CUIl2Re77QdqXsshykhlUzGU
         ZRE35VNPdS6hVSWSxbDx4TXNMy80/r/VKXeXQZSR7VxEad8J6gpjfhsExEyg7qX01VaK
         TpvQ==
X-Gm-Message-State: ABy/qLY8fVaS/uahpI90xtIMqtf0ddMzgAfMzxQz7TdQoTW8fSTz4bac
	rL2NHbEqiLGGmeHqiam2Vp8yXQ==
X-Google-Smtp-Source: APBJJlF/3jq9D6dGWILWuPZqPWOO2eVUUSeT2OYvPtJDFMk/nXyWLvKlRdfiSnt1TvyeRIWwt+jppA==
X-Received: by 2002:a2e:b0fb:0:b0:2b9:eb0f:c733 with SMTP id h27-20020a2eb0fb000000b002b9eb0fc733mr2426646ljl.35.1690892608710;
        Tue, 01 Aug 2023 05:23:28 -0700 (PDT)
Received: from localhost ([212.23.236.67])
        by smtp.gmail.com with ESMTPSA id si15-20020a170906cecf00b00993004239a4sm7585260ejb.215.2023.08.01.05.23.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Aug 2023 05:23:27 -0700 (PDT)
Date: Tue, 1 Aug 2023 14:23:26 +0200
From: Jiri Pirko <jiri@resnulli.us>
To: Vadim Fedorenko <vadim.fedorenko@linux.dev>
Cc: Jakub Kicinski <kuba@kernel.org>,
	Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>,
	Jonathan Lemon <jonathan.lemon@gmail.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Milena Olech <milena.olech@intel.com>,
	Michal Michalik <michal.michalik@intel.com>,
	linux-arm-kernel@lists.infradead.org, poros@redhat.com,
	mschmidt@redhat.com, netdev@vger.kernel.org,
	linux-clk@vger.kernel.org, Bart Van Assche <bvanassche@acm.org>
Subject: Re: [PATCH net-next 06/11] dpll: netlink: Add DPLL framework base
 functions
Message-ID: <ZMj5PrwZK3Fat7fT@nanopsycho>
References: <20230720091903.297066-1-vadim.fedorenko@linux.dev>
 <20230720091903.297066-7-vadim.fedorenko@linux.dev>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230720091903.297066-7-vadim.fedorenko@linux.dev>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,
	T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Thu, Jul 20, 2023 at 11:18:58AM CEST, vadim.fedorenko@linux.dev wrote:

[...]

>+
>+static int
>+dpll_pin_parent_device_set(struct dpll_pin *pin, struct nlattr *parent_nest,
>+			   struct netlink_ext_ack *extack)
>+{
>+	struct nlattr *tb[DPLL_A_MAX + 1];
>+	enum dpll_pin_direction direction;
>+	enum dpll_pin_state state;
>+	struct dpll_pin_ref *ref;
>+	struct dpll_device *dpll;
>+	u32 pdpll_idx, prio;
>+	int ret;
>+
>+	nla_parse_nested(tb, DPLL_A_MAX, parent_nest,
>+			 NULL, extack);

Please pass proper policy instead of NULL here.
dpll_pin_parent_device_nl_policy


>+	if (!tb[DPLL_A_ID]) {
>+		NL_SET_ERR_MSG(extack, "device parent id expected");
>+		return -EINVAL;
>+	}
>+	pdpll_idx = nla_get_u32(tb[DPLL_A_ID]);
>+	dpll = xa_load(&dpll_device_xa, pdpll_idx);
>+	if (!dpll)
>+		return -EINVAL;
>+	ref = xa_load(&pin->dpll_refs, dpll->device_idx);
>+	ASSERT_NOT_NULL(ref);
>+	if (tb[DPLL_A_PIN_STATE]) {
>+		state = nla_get_u8(tb[DPLL_A_PIN_STATE]);
>+		ret = dpll_pin_state_set(dpll, pin, state, extack);
>+		if (ret)
>+			return ret;
>+	}
>+	if (tb[DPLL_A_PIN_PRIO]) {
>+		prio = nla_get_u8(tb[DPLL_A_PIN_PRIO]);
>+		ret = dpll_pin_prio_set(dpll, pin, prio, extack);
>+		if (ret)
>+			return ret;
>+	}
>+	if (tb[DPLL_A_PIN_DIRECTION]) {
>+		direction = nla_get_u8(tb[DPLL_A_PIN_DIRECTION]);
>+		ret = dpll_pin_direction_set(pin, dpll, direction, extack);
>+		if (ret)
>+			return ret;
>+	}
>+	return 0;
>+}
>+
>+static int
>+dpll_pin_parent_pin_set(struct dpll_pin *pin, struct nlattr *parent_nest,
>+			struct netlink_ext_ack *extack)
>+{
>+	struct nlattr *tb[DPLL_A_MAX + 1];
>+	enum dpll_pin_state state;
>+	u32 ppin_idx;
>+	int ret;
>+
>+	nla_parse_nested(tb, DPLL_A_MAX, parent_nest,
>+			 NULL, extack);

Please pass proper policy instead of NULL here.
dpll_pin_parent_pin_nl_policy


>+	if (!tb[DPLL_A_PIN_ID]) {
>+		NL_SET_ERR_MSG(extack, "parent pin id expected");
>+		return -EINVAL;
>+	}
>+	ppin_idx = nla_get_u32(tb[DPLL_A_PIN_ID]);
>+	state = nla_get_u8(tb[DPLL_A_PIN_STATE]);
>+	ret = dpll_pin_on_pin_state_set(pin, ppin_idx, state, extack);
>+	if (ret)
>+		return ret;
>+
>+	return 0;
>+}

[...]

