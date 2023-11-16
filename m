Return-Path: <netdev+bounces-48446-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BD9487EE58D
	for <lists+netdev@lfdr.de>; Thu, 16 Nov 2023 17:52:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EE6A21C2097D
	for <lists+netdev@lfdr.de>; Thu, 16 Nov 2023 16:52:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E79128361;
	Thu, 16 Nov 2023 16:52:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="g7L1Bsii"
X-Original-To: netdev@vger.kernel.org
X-Greylist: delayed 313 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 16 Nov 2023 08:52:05 PST
Received: from mout.web.de (mout.web.de [212.227.15.14])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 528231A8;
	Thu, 16 Nov 2023 08:52:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
	t=1700153521; x=1700758321; i=markus.elfring@web.de;
	bh=6S/RFMzhybHWCrHyIb3KI2oR/z3S7irZPJDIIkKG6ow=;
	h=X-UI-Sender-Class:Date:To:Cc:References:Subject:From:
	 In-Reply-To;
	b=g7L1BsiiMFc9uzSqKvwVKXDfyTGDAy7s3E3YO1f1BnuRkUaViDYINWqmW7++wFuF
	 nKD1YWwve+NZ9QCeN6mkTrmjkIodCmcAECXw5EBESEQflnfDLHE9boc3+8SHl41X+
	 WQvhfiFDPsnTOyeJyvyJjwzK2ybj4rtAjybppvDEHJYSrz2l8YgwU/I5Tb4IjWnH8
	 h/Q4QOZWpfxicUwW/dIrXTxD9hfGcbyAAZ2JfHT891gIiJYBYWBCJTsiHPq0mBWz4
	 mwEoPTfDAXPsiOxEz/KxaO0Smxs2cyVFaRn3qprsMW4uwdxVLUlxXwUfyMwaaPM/6
	 pFq08FGB6otbXF3Dvw==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.90.95]) by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MdO9E-1rd0KR1sJM-00ZEnv; Thu, 16
 Nov 2023 17:46:35 +0100
Message-ID: <ab3b74bf-cbf2-4e05-8a02-d8039d712150@web.de>
Date: Thu, 16 Nov 2023 17:46:13 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Minjie Du <duminjie@vivo.com>, opensource.kernel@vivo.com,
 netdev@vger.kernel.org
Cc: David Ahern <dsahern@kernel.org>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 LKML <linux-kernel@vger.kernel.org>
References: <20231116022213.28795-1-duminjie@vivo.com>
Subject: Re: [PATCH v2] net/tcp: use kfree_sensitive() instend of kfree() in
 two functions
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <20231116022213.28795-1-duminjie@vivo.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:5esQfuXyC+xmKWMvbojAv+dGoR+lQMP5LTjCitvWpU9vPrO1blm
 4qHfKMMdUXtTZDSMtQL/0OmKBBs3j8IFU1IXiyULkzMdDKILsPUjOyer73duInMWjs/eYwD
 FelyCZGRyptuCSLMHtH+mCeCHQ8PRZ0Dox5qLOFe9PB8i9CH+fJHERGWKXfYYsoESwCJE/r
 E39e9ZdERrSnOl17NSAdA==
UI-OutboundReport: notjunk:1;M01:P0:Fj667MnM4iY=;Aih/313UfwHLlINCjtAyJ4p99Yd
 VW4AHk+Z1PHuy0As5kOPtrEEO3x4Km4ryTXDmrx7xQmxfdldx+wOMTBZf1vpTKyeQMs8gtkQO
 wgPkrDF2WMM4ypI+cM1J07UkwE8liBgAvliGatFc6aIgPYg8tEsmH8OPpqNwNgV/gaECHlyLQ
 J5hOtx/kTXr7IJWNDjASaD/HyTuAaQwGGtIbQmJPkVw0kKXDMinlTxij0hASXfHX0Cqbsz/A7
 Uxz5Gxz2EMgQASKdgGY4YVVEwlBSGXw7+7w0MoXRY3nibE7yqQN6Krq2mAHClJ5sDcRaYMxU3
 9CzzgjxCz50vURrkTs5kGn4nH4gekK4YW1G/mFmN1Tz+pLi/X9gltnMuP7IWYCCybZEH6YTOS
 kgl4pDhUUCT/LAzfYfH+D+XoZUU7Vy8s9CaDDARW9KVLiTJYuxzWX4CO8PXprzRFXf/S1QwkR
 sumntw4CNUnz1cpE5cuhu+fEuHwLhEk6guo84uNJ3fIHXD785CsmdK3XtSEfvVKXEV3YXEXVh
 7FpHEADdecRiMuoV2c0xrvVaZqDXlXk/s6KT7bMNURwLmCyRDpc+19EvgupyJvCxiDpdTASBX
 64koC5+oPW5apm8mpyGOBjI0N5jMUrIIx/RF27h9K8WLEwxroPg+Ka1ZvgdgYS9Fu7aqsNjyU
 YpwwoD1IWSYxQpGws353x2BmaurcWZoTKfeUxU9spwbODWWeyE08RP0QKaqHCfvMUW8nYXGxs
 +mlp+wb030ycEfPlgh+ozCxif4Fow3NuFT+89Buc3I0k1hRoPhO4K+NW2omqbVRC8rbT6t1St
 SWQhgA0zkk4bQSWeIDtzaID5wP0jaoWouQTkVYoz6Tuy5QqqjHTV715t5hP2cCQf6m1UfUHxP
 tBwqGSqIG3MzbMrTIQ8HF61A+dIngEzZ//GNoD24A3o+ulNaNgSjQRczj03vSD03pM626kpU5
 9nrk4Q==

Please avoid a typo in the patch subject.

Regards,
Markus

