Return-Path: <netdev+bounces-53388-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F2FF8802C16
	for <lists+netdev@lfdr.de>; Mon,  4 Dec 2023 08:33:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 104F51C2095F
	for <lists+netdev@lfdr.de>; Mon,  4 Dec 2023 07:33:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5F059449;
	Mon,  4 Dec 2023 07:33:53 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from shmail0.sohard.de (shmail0.sohard.de [87.140.57.250])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFC65D7;
	Sun,  3 Dec 2023 23:33:49 -0800 (PST)
Received: from localhost (localhost [127.0.0.1])
	by shmail0.sohard.de (Postfix) with ESMTP id 4B8CBBE08E2;
	Mon,  4 Dec 2023 07:33:48 +0000 (UTC)
Received: from shmail0.sohard.de ([127.0.0.1])
 by localhost (shmail0.sohard.de [127.0.0.1]) (amavis, port 10032) with ESMTP
 id 0d81F8dSAOyK; Mon,  4 Dec 2023 07:33:48 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by shmail0.sohard.de (Postfix) with ESMTP id 1CE7ABE08E3;
	Mon,  4 Dec 2023 07:33:48 +0000 (UTC)
X-Virus-Scanned: amavis at shmail0.sohard.de
Received: from shmail0.sohard.de ([127.0.0.1])
 by localhost (shmail0.sohard.de [127.0.0.1]) (amavis, port 10026) with ESMTP
 id Mg7LYY86eXRO; Mon,  4 Dec 2023 07:33:48 +0000 (UTC)
Received: from [192.168.178.40] (p5b111cfc.dip0.t-ipconnect.de [91.17.28.252])
	by shmail0.sohard.de (Postfix) with ESMTPSA id C926FBE08E2;
	Mon,  4 Dec 2023 07:33:47 +0000 (UTC)
Message-ID: <19011a70-7932-4773-ac1d-ac1459400728@sohard.de>
Date: Mon, 4 Dec 2023 08:33:48 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] arcnet: restoring support for multiple Sohard Arcnet
 cards
Content-Language: en-US
To: Jakub Kicinski <kuba@kernel.org>
Cc: Michael Grzeschik <m.grzeschik@pengutronix.de>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20231130113503.6812-1-thomas.reichinger@sohard.de>
 <20231201200514.1b0b55a1@kernel.org>
From: Thomas Reichinger <thomas.reichinger@sohard.de>
In-Reply-To: <20231201200514.1b0b55a1@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

yes, commit 5ef216c1f848 introduced a bug

Am 02.12.2023 um 05:05 schrieb Jakub Kicinski:
> On Thu, 30 Nov 2023 12:35:03 +0100 Thomas Reichinger wrote:
>> commit 5ef216c1f848 ("arcnet: com20020-pci: add rotary index support")
> 
> Fixes: 5ef216c1f848 ("arcnet: com20020-pci: add rotary index support")
> 
> right?


