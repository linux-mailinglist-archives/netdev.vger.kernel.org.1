Return-Path: <netdev+bounces-229972-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 339E3BE2C57
	for <lists+netdev@lfdr.de>; Thu, 16 Oct 2025 12:27:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 158854E0496
	for <lists+netdev@lfdr.de>; Thu, 16 Oct 2025 10:27:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2362532863B;
	Thu, 16 Oct 2025 10:27:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="rm+1Rt41"
X-Original-To: netdev@vger.kernel.org
Received: from mout.web.de (mout.web.de [212.227.15.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B035B29CE1;
	Thu, 16 Oct 2025 10:27:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760610475; cv=none; b=rWqF1egfzFXEkHQ1BC4s4PiZtr/9aTFPIeYokm66Td0Q0NQznnOtLZsWghXk4V+okzB2oMt00O5c+faXmT5ZKdeEwI1ycUjaNz/d/uCClCNbgSFida2t1Mw+MW2urlahYJb+T+q/ReUcQU74tHRz+MO1Vxc3eEmfcVuG1P3ZWjQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760610475; c=relaxed/simple;
	bh=lJ9v2xcx1JnSMx93hvwga21ohxCuyZf3tm6RnYMFOKs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rH00kgCXFOVwYIA5AXa2lwguOQgYFGivuq5aChgLUEu2yjWBpTEZq56qNBfjyz+th4ZXbHctou72+cqyzvBSddRwKycDLw1wQcqgfpo/RYM47iUEuzCbsxg3gLS1+sWi1y3Jnc9dW2qWV9EV41zpzpZHqnNatKNw/NeBJ+ZRVKY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=rm+1Rt41; arc=none smtp.client-ip=212.227.15.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1760610379; x=1761215179; i=markus.elfring@web.de;
	bh=lJ9v2xcx1JnSMx93hvwga21ohxCuyZf3tm6RnYMFOKs=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=rm+1Rt410py7jzDohBK15D7DXSNxkzhlMrn3xurftrFsXIvjBo0J42KKKXHRSsNu
	 FofgvhBW4tLFKNBG2sYMPNlSC2NXZA6Rv2Rs1dmr+7qzWAx2sYAS+ZfG7Jc7j5uBj
	 5QxYKmlobWPU3dsJ40K9RJHaHfNTXJq2Y7ziejlihu8iY22G6Es7NQtuiOL5ELV9+
	 G+yXWnP7al6KRYHpOChNp0ABBkLSBQ05JyCPDd81Md1lulHObjhwYNZyxFSAI0klT
	 j6DMprvfBAg1yUeeeDpPbRaALLW4Jg7uYlaMTZVArvScYnhNKu+4VSSWCNHW/FKkn
	 xUqxg0bSDG/00lZ+bg==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([94.31.69.241]) by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MLzin-1urwtO1IjR-00WZWN; Thu, 16
 Oct 2025 12:26:19 +0200
Message-ID: <3ed166fc-6641-4e7b-a2ba-2f17081af1d3@web.de>
Date: Thu, 16 Oct 2025 12:26:13 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [net-next 2/9] hinic3: Add PF management interfaces
To: Fan Gong <gongfan1@huawei.com>, Zhu Yikai <zhuyikai1@h-partners.com>,
 netdev@vger.kernel.org
Cc: linux-doc@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
 Andrew Lunn <andrew+netdev@lunn.ch>, Bjorn Helgaas <helgaas@kernel.org>,
 Christophe Jaillet <christophe.jaillet@wanadoo.fr>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Gur Stavi <gur.stavi@huawei.com>, Jakub Kicinski <kuba@kernel.org>,
 Joe Damato <jdamato@fastly.com>, Jonathan Corbet <corbet@lwn.net>,
 Lee Trager <lee@trager.us>, luosifu@huawei.com, luoyang82@h-partners.com,
 Meny Yossefi <meny.yossefi@huawei.com>, Michael Ellerman
 <mpe@ellerman.id.au>, Paolo Abeni <pabeni@redhat.com>,
 Przemek Kitszel <przemyslaw.kitszel@intel.com>,
 Shen Chenyang <shenchenyang1@hisilicon.com>, Shi Jing
 <shijing34@huawei.com>, Simon Horman <horms@kernel.org>,
 Suman Ghosh <sumang@marvell.com>, Vadim Fedorenko
 <vadim.fedorenko@linux.dev>, Wu Like <wulike1@huawei.com>,
 Xin Guo <guoxin09@huawei.com>, Zhou Shuai <zhoushuai28@huawei.com>
References: <b59d625d-18c8-49c9-9e96-bb4e2f509cd7@web.de>
 <20251016085543.1903-1-gongfan1@huawei.com>
Content-Language: en-GB, de-DE
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <20251016085543.1903-1-gongfan1@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:nxYgTsho/n3tNqKGoyXovz3zHZrFhFsam3viLf1NX2PU+V6Oncj
 1iCP437tSZMp+xBm1W+Ohbgof7lAzVdvxJeUJAJPdyg0Fm58Sb/1eSEnjYifCqutUvXwL+N
 OiovrWEr0nACManebaf9NfjBdI63zDmbYaaGsqmMAQm6MHVkTaPBZNqRUyY8eCFGELmLwHs
 DRrByAYBIgEAzmqaErbyA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:d7DCC4oCh3o=;8DYm32kJ+SSA7R8co/mkQ2/74U1
 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

> I can't quite understand "the distribution of recipient information betw=
een message
> fields". Can you explain this further?

Can it occasionally be more desirable to specify other recipients
in the field =E2=80=9CTo=E2=80=9D (instead of =E2=80=9CCc=E2=80=9D)?

Regards,
Markus

