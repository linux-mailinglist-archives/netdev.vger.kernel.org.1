Return-Path: <netdev+bounces-94574-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 388C58BFEA9
	for <lists+netdev@lfdr.de>; Wed,  8 May 2024 15:23:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E8E1928A720
	for <lists+netdev@lfdr.de>; Wed,  8 May 2024 13:23:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E20AE78C97;
	Wed,  8 May 2024 13:23:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="vobyrqzP"
X-Original-To: netdev@vger.kernel.org
Received: from mout.web.de (mout.web.de [212.227.15.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2ACDD78C85;
	Wed,  8 May 2024 13:23:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715174623; cv=none; b=lNkMfFn9/X3xwFUeNwgzKwfGXxpy619AuFKK7ZAGY6oxRFRt+P6h6gHXR7YbgmsZZ0vlhm5m7cTUjRVeu/O/4qtdbiLjAZLi6o94eAIuljyKk+XUqEewHpdOdDp9pMVmjk59WVGE8Vq3X/zuZTc9kFqVMV14Ru+YtxzQxfnBw80=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715174623; c=relaxed/simple;
	bh=nIua7Nli79Cy4ClZ3sm15/ruW09uct03XQCexKb3oa8=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:Subject:From:
	 In-Reply-To:Content-Type; b=QrjiuFLFyMiLB7Xiof8RPDYoZ7+LKRJv9CPukPQoSHBb3Q/joh5Q85Hlqyf/AtlhhyuLjRDk5yLxuy+9HqDiNgblvyn+vyc8MZJkkp8Vsl5wLrh5JWhspy9SiRYzlQG6W7fVTdjSZd9vPeDTv3Fkn4QuNBIddlRc+KQneR3C1tM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=vobyrqzP; arc=none smtp.client-ip=212.227.15.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1715174599; x=1715779399; i=markus.elfring@web.de;
	bh=nIua7Nli79Cy4ClZ3sm15/ruW09uct03XQCexKb3oa8=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:Cc:References:
	 Subject:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=vobyrqzPFQj1QXKmExAgMKdsgPHytnwtgj7+tst8ZcjpJPoL2aRaCRnLcsuFzeSx
	 ztdu0gKAtXt6+jqfwHOxHGLfDWzJkN86BwETLeHb1mukl0HWj59VOSJ2KSGVgUL9b
	 SxT5XbXJ/Cq/ziDk5dJn8FM3Q1iq7r9CUbGQ4KN+a3g92U4QCOR42jJNXzyLhuKO6
	 A5X7A+8+y3hgiNB4sp6sf3k4+Qs1AfMYf5saPXaM2CjpJh+9PuDgqo7DlbwjwfZB1
	 r78PFrSAgS2gmDIQ9KQBLKMlmXT+T+xr+RWfHZdhw+6JLl4JrUb7WrnYmpPDmj7iD
	 PxM5rJLQiJrXttv5Vg==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.89.95]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1M5j1q-1rxWX70Qyg-00GVD4; Wed, 08
 May 2024 15:23:19 +0200
Message-ID: <334f5ae7-17cb-4c67-81d2-ffbfa3812ee9@web.de>
Date: Wed, 8 May 2024 15:23:17 +0200
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
References: <20240507225945.1408516-5-ziweixiao@google.com>
Subject: Re: [PATCH net-next 4/5] gve: Add flow steering adminq commands
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <20240507225945.1408516-5-ziweixiao@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:N7BodfaSkicQ4rqScWElvnOEDSWQXr8ncFDCNFCGpJhmX95GA1X
 eyAMB/ukemGRTPwUy2qVBviXG30agC3aDpqpxKAl9tmkNmYPYm4rMtu2WRsvuVDQcYdCgpS
 zvdacP3xDzr8CPgb/Ri5GmYt3sIRzNwQuK2gUi3IrTxpIItlBM9fYN5eWBhpz731YdG+lpA
 q7ZKMW2Q20FqRjISiVN1A==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:7r+EZz22b5I=;CmayfH5iTD6B3vfq0Nfup+A/8CW
 PC73mycydm3uzYJ0eYoPc/6cuXSDpCpt9CSYsss5OeF3M9TUroNh4OGx3l4AKg3eV+d59ezU+
 bL2HsQMy9nY1cP8T4bE+oS8mqJhCuG94HFG5TKfXw6/TanWu+vKGEGYI4GR7Q71EFGD7w0mhh
 jon6Hnd9YaL0PVoKPLZfSS/CJg+k1wgS3K3k3m7FTWOMg1J8nMJprLMd7ZUaRAYy+51HF+1ut
 Cis0+R6+p+J3iua69qIJCf/WbCzvlsAD7cdpLEMfHQyQRMOamH/pDNaSJXYldgT890qDaJ9uu
 DaiB7XVHPoASq2bGV6sZz1s0C8T3/1t4LXQd8F3a4jKhuIamdFFnQQnkJRIb29KQeIJ+H7HjJ
 Edq/RE2cANUKbLNLbC15yECUobJQo4PqLZcahNMxAfYtpzlnQG3E9dpRQKjXhv++9evplVy2z
 mPagn46k01eOO+dNOcjmCip7oXZjuvfEo2naWHsZr+RpUstF/uzSC07seCXBnKh5gZfuqwERu
 f3/MRxTil1vCffl0r4kUoG4W5B37dTZw85iURkO827y2H9BSDTUM/Op5ZTbS4X2WlXxB6DyPZ
 ut++1ThMNg9Vd1COb7nu4/OW2X3wrVFi2Fl7kVD1ywZMH6LxwJa8ZaGmRtr/bgFq3hFU7e5tI
 h/Qli76HQlsD98nPznq4gMPW07x1ijSl6VpfPhvfGC0I2/sq/ay+VAt9/l2l0bRfHYHvjkeAO
 +xr9+dRANwcP7RbggJA9JJ7SPBEdFgCKYrhgG5AoAP4j5SC0lPEWlc/HGPCVgkCZ3eIED9EdS
 UU5TtlsGefBS/u+uWClKk+2Bwh4HRskJhLAxvbnNAiCtE=

> Adding new adminq commands for the driver to configure and query flow
> rules that are stored in the device. =E2=80=A6

Will corresponding imperative wordings be desirable for an improved change=
 description?
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Do=
cumentation/process/submitting-patches.rst?h=3Dv6.9-rc7#n94

Regards,
Markus

