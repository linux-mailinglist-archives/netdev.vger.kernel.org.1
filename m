Return-Path: <netdev+bounces-23525-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D4A9F76C578
	for <lists+netdev@lfdr.de>; Wed,  2 Aug 2023 08:44:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 079CD1C211EE
	for <lists+netdev@lfdr.de>; Wed,  2 Aug 2023 06:44:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA7BC110C;
	Wed,  2 Aug 2023 06:44:28 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFE40EBB
	for <netdev@vger.kernel.org>; Wed,  2 Aug 2023 06:44:28 +0000 (UTC)
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E1681FFA
	for <netdev@vger.kernel.org>; Tue,  1 Aug 2023 23:44:18 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id a640c23a62f3a-9923833737eso926589466b.3
        for <netdev@vger.kernel.org>; Tue, 01 Aug 2023 23:44:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20221208.gappssmtp.com; s=20221208; t=1690958656; x=1691563456;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Zty1MQp2fqYuL5acJsJmqB6ON567Dd/KEwhZZ/hkER4=;
        b=ZlarRuNnrHGLpru8dqXer8XriPIfS3fjIQVOEXX29E/XVNMq3WdKLxwHMcliyEnxkp
         vFdGAWTcSux+yK6W3MMnyubRZMA/Z1viX7oVCfz3hliJz9F14f+PnZsm46pU27LGGIG2
         9d1ardtyIyhJg2dJEid+zCwURy7LqphJ/Kj+weoksx7oLypqDESguE3ynIPWRW12+3gS
         udIQt7AABAxCAbtorSjpwFUe+7LcWIw3MsA2kGKiYlyBuB0lgwj0JiapJ1oXXWmOiLWG
         raMzWSm2tyK+cs7W/BPtR4VlPAx4hX9+N03+ARu5Bk7G2vIZckvw0v3/T/fT8jvzORLT
         de4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690958656; x=1691563456;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Zty1MQp2fqYuL5acJsJmqB6ON567Dd/KEwhZZ/hkER4=;
        b=lSEz4a7yNMpfsBY99YIBQA+e9QOQYPuPIi9Mc9zVSvOZYmBmhn9YfbV/2tBAl1tyPW
         4ZxO4qS0c8qM+v8U3XfkLn5xPD/iz7h/kEDYhpplLxMUH3kh2eu+U8fJ47eN+v7EILOx
         xn+zz+F+hESyG/ExiCbpvd7XiamnFbOWFpn1aMbjAgVjCkyw1qTtF46th8T8zUVrBS86
         ZxrXeUPiU5JotRIxbqR2geh7myRfQ1UeHe/Zovrh243GkzJOHqGXIDQJccjbhNHcX7+p
         23n+efUXQzwu5gx3SEwuEqKN1gMfr1cuHLwvrngvnRIoa9GGbRCU7/5wIQo8n3qXi5ZV
         Zjpw==
X-Gm-Message-State: ABy/qLZ+CaKz2BX6Mpjqwba1NrjwPxCdL1SSA7AhirVAWvo8mtuafvdj
	zfYmv1D6Y80joZz4obV1/INt6A==
X-Google-Smtp-Source: APBJJlGMkqkxAahKCNn0OLtVF1JDzLlGazuyrOHghTGuXZAdS3CqnniDmDFfEAB7P832jSLjTs/v7w==
X-Received: by 2002:a17:906:76d9:b0:99b:d594:8f8a with SMTP id q25-20020a17090676d900b0099bd5948f8amr4604031ejn.0.1690958656633;
        Tue, 01 Aug 2023 23:44:16 -0700 (PDT)
Received: from localhost ([212.23.236.67])
        by smtp.gmail.com with ESMTPSA id si15-20020a170906cecf00b00993004239a4sm8615938ejb.215.2023.08.01.23.44.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Aug 2023 23:44:16 -0700 (PDT)
Date: Wed, 2 Aug 2023 08:44:15 +0200
From: Jiri Pirko <jiri@resnulli.us>
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, pabeni@redhat.com, davem@davemloft.net,
	edumazet@google.com, moshe@nvidia.com, saeedm@nvidia.com,
	idosch@nvidia.com, petrm@nvidia.com
Subject: Re: [patch net-next 4/8] devlink: add split ops generated according
 to spec
Message-ID: <ZMn7Px9P1Jep01Qm@nanopsycho>
References: <20230801141907.816280-1-jiri@resnulli.us>
 <20230801141907.816280-5-jiri@resnulli.us>
 <20230801115655.296b3d28@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230801115655.296b3d28@kernel.org>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,
	T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Tue, Aug 01, 2023 at 08:56:55PM CEST, kuba@kernel.org wrote:
>On Tue,  1 Aug 2023 16:19:03 +0200 Jiri Pirko wrote:
>> Improve the existing devlink spec in order to serve as a source fot
>
>s/fot/for/
>
>> generation of valid devlink split ops for the existing commands.
>> Add the generated sources.
>
>> +/* DEVLINK_CMD_GET - do */
>> +const struct nla_policy devlink_get_nl_policy[DEVLINK_ATTR_DEV_NAME + 1] = {
>> +	[DEVLINK_ATTR_BUS_NAME] = { .type = NLA_NUL_STRING, },
>> +	[DEVLINK_ATTR_DEV_NAME] = { .type = NLA_NUL_STRING, },
>> +};
>
>What's the impact of narrowing down the policies? Could you describe it
>in the commit message?

Should be no impact afaik. The code does not care about the rest of the
attributes and dont-validate-strict will allow any garbage to be passed
by the user. I will put a note in the commit message as you asked.


