Return-Path: <netdev+bounces-94544-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 022058BFCFF
	for <lists+netdev@lfdr.de>; Wed,  8 May 2024 14:18:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B18F4285B36
	for <lists+netdev@lfdr.de>; Wed,  8 May 2024 12:18:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 185F783CB2;
	Wed,  8 May 2024 12:18:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="j39c/nXE"
X-Original-To: netdev@vger.kernel.org
Received: from mout.web.de (mout.web.de [212.227.15.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 782C13D96D;
	Wed,  8 May 2024 12:18:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715170695; cv=none; b=AvDqwWWWGm9p9sKOoo/eJUM8KI378Ol1QRQtnOO68UXsNoZXk7eeaa6DpSAd7IFuyR2WdY1GfPOkrX4xl73v7rNse4EQ7UmhsQIl05aa42S+avBPBBODiv8APfh/zdWmUrF2iIHIfkS9GsmV6Zjtv30/MP9kwC768Fyy4DFjknw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715170695; c=relaxed/simple;
	bh=6iEhN1S8UsmfprfXOzUl363oRHp0Fe9qBJJDny+zzaM=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:Subject:From:
	 In-Reply-To:Content-Type; b=aFj4v+H7NoHSCFcUcgvCcwCZSIaXpikbfzjH3RiB/EH+A0gseROijuWU067VI+Bf0E0zqimoqxlVfOAKTpEqX3bogVqShhTIyUMKSZuVMOOexgMONKkefTx3dLgGSLnmzBPled8trrNW4T6FRSQv+B/bo7gZNrJ4iAeDfvS0Pfk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=j39c/nXE; arc=none smtp.client-ip=212.227.15.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1715170679; x=1715775479; i=markus.elfring@web.de;
	bh=6iEhN1S8UsmfprfXOzUl363oRHp0Fe9qBJJDny+zzaM=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:Cc:References:
	 Subject:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=j39c/nXErAsocWb1vCoHKE5WbM7TAF8UqTxYePMGLZbwJVvbtjlO4IHha6PIPgGd
	 cElnH0QBA9X+M39ies7Py2dP9H+5GeNSxbDOPoC4vxKOEHouFS0nOpks2/rmOoH1G
	 yAaoPd7YiJyy+wBer/EW9JGN0RQ88ZcE8i46zkr+xqKniw8GEy+qQlUtsDVhYWe1Z
	 3+Wx+51bjihboEL7OfAXrWyr91nPOevIEXC/5dYLwgDXpgf+8eQMG/F6iFdUE4X+0
	 KslWqyasBwj6iZ4DFm/eb/3KymaPsT6wffXYxpVs1sthGgdLpl85Qksm6CoUEaZZx
	 hvF2fvt6akpGQBivCQ==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.89.95]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1M3V26-1s48HN04f4-009vpa; Wed, 08
 May 2024 14:17:59 +0200
Message-ID: <48013bd6-23f0-4202-8477-99a43bea61bb@web.de>
Date: Wed, 8 May 2024 14:17:58 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Jeroen de Borst <jeroendb@google.com>, Ziwei Xiao <ziweixiao@google.com>,
 netdev@vger.kernel.org, kernel-janitors@vger.kernel.org,
 Harshitha Ramamurthy <hramamurthy@google.com>,
 Praveen Kaligineedi <pkaligineedi@google.com>,
 Willem de Bruijn <willemb@google.com>
Cc: LKML <linux-kernel@vger.kernel.org>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, John Fraker <jfraker@google.com>,
 Paolo Abeni <pabeni@redhat.com>, Shailend Chand <shailend@google.com>,
 rushilg@google.com
References: <20240507225945.1408516-3-ziweixiao@google.com>
Subject: Re: [PATCH net-next 2/5] gve: Add adminq extended command
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <20240507225945.1408516-3-ziweixiao@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:hkmxFdizr7QRCHxy7aV1dP+EbjxjhYYxEUGX72Y3fbddwOUZbBt
 EzUYmU49lYvq6ZproVLtOqueNxYMMfYBhiIvja7QwhsfjeQfIWZeuNXrydspwyEruiOtrx7
 UZykGsZL6T3tPMOsMzA70eC249Slx71IsRAgSfvSr7IZ5He4QJySTGODozpqi16tX0DU9yb
 KJ/sixDjx5t+mF3/+k8bg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:KNG8iU0Pg8Y=;1lCKSHLwWMETexoLLoIKo1Gqe9S
 3SZF/mQs2AWFBXpWW6/CaLI8l+r7y84jaGalGb0pH9FMdyYnTsasIlCKYkpo+QF11qQWL5Kx+
 MCbUqpK2ecC7vx/5DtAHOM8RnNam9vigXima0lMsNhNimu4FwWazCQEmvP1L/j7UtPGKC4dAZ
 mRP4hsTE6amUDanE23Y1XvIS+j+vNoRmepKdpFSAaLC/dG7o4iNuTmTJqA9guqvz2Xs9mv9rE
 LYqroobH3tBnSRqPONXt6b3uC8R3rGJx5HWwNfNHFS8LEygZG1luRSiCgYjCGttcXiq4I8gN1
 qQo/oBC9dipwBdJIkqj2nBIp1DBm3mXUyUnLJnG7SBfr4TUPS0DnInRf1tjjCpuCQVvdWmLXb
 +I+roS7euj13PR/felovlO7MLAHk/YbJwY7KmWbskgOi/55EMkI32suyf9IStRoPgj0/LU6uu
 6qxjCpym9TndJJl8ccqIl070zlgrYUKvXb10gBqppATTbI6zyFY5WGeu6YzMLIDdBiZGBIoU2
 iJSoVSw7fJX7LQyLndjIzwGRT6GBOu/nkRpKj5raexKjQ9yOTnSZmiD2EotLK2NE+Hl/jgcM3
 ulDDcJRMtfjGw4dXQ1QHkg+oXqKjiUFR069W2CwKLZB5XNfiS6E7alBgDjZStZMw7pqlcwDap
 2TEJnHCzG9eEInyKVRyS0pwwnDrhDVmIp8qiGtHxnQd6Efs0iTMQpeJp97UvX77zWUzydTr7N
 UZGqumYRz+7nMAFxH3EB36j/8tvRU6GU+EAB7jce+t3iDaqNRqQsjBvpx+RSWCjIw8MYtCrev
 f/hGUKAdZR/gaT959SZj7iyVqn+O0/TjXjabva3op7sQM=

=E2=80=A6
> This change introduces an extended adminq command to wrap the real
> command with the inner opcode and the allocated dma memory address
=E2=80=A6

Please add imperative wordings for an improved change description.
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Do=
cumentation/process/submitting-patches.rst?h=3Dv6.9-rc7#n94

Regards,
Markus

