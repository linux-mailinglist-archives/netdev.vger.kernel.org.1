Return-Path: <netdev+bounces-42367-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C5B37CE7CD
	for <lists+netdev@lfdr.de>; Wed, 18 Oct 2023 21:35:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DF52CB2104C
	for <lists+netdev@lfdr.de>; Wed, 18 Oct 2023 19:35:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D272645F4B;
	Wed, 18 Oct 2023 19:35:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O9qNl8sG"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7680E339AF;
	Wed, 18 Oct 2023 19:35:07 +0000 (UTC)
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FECD95;
	Wed, 18 Oct 2023 12:35:06 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id a640c23a62f3a-9adca291f99so1130413366b.2;
        Wed, 18 Oct 2023 12:35:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697657705; x=1698262505; darn=vger.kernel.org;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mdbAuIh01zvYAO/ji7UkfeNx7lavYO25iJ0fbPVDVio=;
        b=O9qNl8sGxmrVz/xAJHUaggelUYVH6Cvj9qzzssm4O/0Dr/YgirO2A9n7oEqB7qAy4n
         zlSoNvWnShkGGrhvUnmuU1CgyfMB0pc3H0oKyqkzKjX35V8gxulRlSPpayq5y6mvFZDP
         29N2f8OVi5PUozJ1FoKc1Dq8VGUwcduiRaIrQwkWq9poCOdZW0h82FKN+WcDQ8d9JGfO
         AHl+SrzyocFPqwr5kBrajDQKMM6TtDX5go5efgttLvMo9T4U6RlelijMAZGeKJnYtDth
         pmymoI707BPGnVeqJPh/+VBm4peeqaq7xiXHB70yb01TnOhC8PM/onHy4/nbZH5J6sN1
         SpKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697657705; x=1698262505;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mdbAuIh01zvYAO/ji7UkfeNx7lavYO25iJ0fbPVDVio=;
        b=toTdpglXkE6ZultBkNKyfZuwmsi5mP6ncqgQCbfYeFMG3yUURJfaO65Uz6moTPD1Dw
         LLmDmLX7ome0i8zWrD82iAj5JABXma2eh9RoMzO/8e/lmIcEkqGU7paSD4Mh25Bukw26
         x72fARYxqGB4Jot3AHx8ss4CyjtPy6z7jx0aGUjmy4TKq8NL0R7qYaut2RQ2Ki/mYraM
         tluvqFH3Wi/P6aB9JFCiDS+JJTZC4I0sjJEtmPxM+nthKQ+77oZOf3RUSVj2ySNlyQhI
         g1TIW+4aFcPUalZ0Kb921lLMd3kncnaFk5wfDhP+SJzqYFzHasA/BFkzFs+x8BZFKzyY
         wfVQ==
X-Gm-Message-State: AOJu0Yy7jGSys5nPzyMeSpqjc1OUp3ymvUVtgX8Gkr71j42raJkLhdio
	UhJsgFLwMxxKn0ikXo3VGqJS+t5To1g=
X-Google-Smtp-Source: AGHT+IGiUcXj5yb4s+p9+qjNpekt7IucfY/PWlpwxACKFBZm/CyZbddoT0b9jndYMOCCTin8SCGf6g==
X-Received: by 2002:a17:907:1c05:b0:9bd:bb63:49db with SMTP id nc5-20020a1709071c0500b009bdbb6349dbmr242650ejc.7.1697657704553;
        Wed, 18 Oct 2023 12:35:04 -0700 (PDT)
Received: from [192.168.1.122] (cpc159313-cmbg20-2-0-cust161.5-4.cable.virginm.net. [82.0.78.162])
        by smtp.gmail.com with ESMTPSA id o10-20020a170906600a00b00992b510089asm2271823ejj.84.2023.10.18.12.35.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 18 Oct 2023 12:35:04 -0700 (PDT)
Subject: Re: [PATCH net-next] docs: networking: document multi-RSS context
To: Jakub Kicinski <kuba@kernel.org>, davem@davemloft.net
Cc: netdev@vger.kernel.org, edumazet@google.com, pabeni@redhat.com,
 corbet@lwn.net, linux-doc@vger.kernel.org
References: <20231018010758.2382742-1-kuba@kernel.org>
From: Edward Cree <ecree.xilinx@gmail.com>
Message-ID: <e551a21f-6302-ed68-2062-c7e6a36a02c1@gmail.com>
Date: Wed, 18 Oct 2023 20:35:03 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20231018010758.2382742-1-kuba@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit

On 18/10/2023 02:07, Jakub Kicinski wrote:
> There seems to be no docs for the concept of multiple RSS
> contexts and how to configure it. I had to explain it three
> times recently, the last one being the charm, document it.
> 
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> ---
> CC: ecree.xilinx@gmail.com
> CC: corbet@lwn.net
> CC: linux-doc@vger.kernel.org
> ---

Reviewed-by: Edward Cree <ecree.xilinx@gmail.com>

Thanks for doing this (and sorry for not documenting it in the
 first place).

-ed

