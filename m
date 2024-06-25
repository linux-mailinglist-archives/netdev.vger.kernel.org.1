Return-Path: <netdev+bounces-106619-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 43AA6916FFC
	for <lists+netdev@lfdr.de>; Tue, 25 Jun 2024 20:18:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4E3EA1C23079
	for <lists+netdev@lfdr.de>; Tue, 25 Jun 2024 18:18:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C746F176ADA;
	Tue, 25 Jun 2024 18:17:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="jAxptxcg"
X-Original-To: netdev@vger.kernel.org
Received: from mout.web.de (mout.web.de [212.227.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53AF7176AA9;
	Tue, 25 Jun 2024 18:17:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719339478; cv=none; b=eWKRlK2lAVrxS9/cQjQv7UCza6/ExyG+kc1CSL7gQPtUV2ib/96CM+qxWqLD20JCyKxIajaX5YPhqS1wjnrHPAqwSNjsgJi66QC2bfgxrlML4QAchVuIzf+4mF9DHmZCGbQUAQMnJzVCd/omPDu4y795R9YHdgR6378P5J2auXc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719339478; c=relaxed/simple;
	bh=yKqbGUSr9xG5PlOMdfCmbaaig9dDXUqSxbsCfS6/r44=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:Cc:
	 In-Reply-To:Content-Type; b=RjQxkzFZOMPgyIVt4Bj/GlePjiW0KUyJCGly7LiWnVKgVgRJi2AZOex+UiXvhmJl5rxOzJKlkbqdTAfpTVoL7/QLUw2LTF4zeNbyEjnlj/x/QVPVcdswSP+QTscMBFtPTeWRkCVZvRCoKqiNCqc1bzDUn2GcNaGQHMLFzYd/7dU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=jAxptxcg; arc=none smtp.client-ip=212.227.17.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1719339445; x=1719944245; i=markus.elfring@web.de;
	bh=MAE5lGIuZ6oAoIWiGJEas5hHGJYgTmQEFbEicXRr5LU=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:
	 References:From:Cc:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=jAxptxcgx0KZcsDozAIJ+OtqEZfLVF7Aqv/gL7yCqQtLfhI3FzKh1A8iEm7dhByn
	 BZ07JRTzH/VhtUyd6VS47QYzfU3nvAGpFRVMIb84htkUcabkM5GoUfVNhOhGFwD6T
	 TedudFNy6wg3gfjCQUtkoGjdYKr2QbNgemq9/OXMLI4haQNQlNfHJwSccwT0xnc13
	 VcHq4q/ga4dfsjiaxo2Gdt47P5+p+5Bov9cJUPyaFCdgV8ugfLopM4qF9Y6zhgJPI
	 YBWVkwezJMH6N5syFyqHBDVdkFs/SpJPyYfYusQRX4ZToAf5QkZQ40klKYRNIiYKx
	 0kRdsGyeXtneCVRkzQ==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.85.95]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1McIkg-1suP1N2BpM-00jPae; Tue, 25
 Jun 2024 20:17:25 +0200
Message-ID: <8fd713c2-5b85-4223-8a06-f2cedc2a1fb8@web.de>
Date: Tue, 25 Jun 2024 20:17:23 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [net PATCH v2 0/7] octeontx2-af: Fix klockwork issues in AF
 driver
To: Suman Ghosh <sumang@marvell.com>, netdev@vger.kernel.org
References: <20240625173350.1181194-1-sumang@marvell.com>
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
Cc: LKML <linux-kernel@vger.kernel.org>, "David S. Miller"
 <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
 Jerin Jacob <jerinj@marvell.com>, Eric Dumazet <edumazet@google.com>,
 Geethasowjanya Akula <gakula@marvell.com>,
 Hariprasad Kelam <hkelam@marvell.com>, Linu Cherian <lcherian@marvell.com>,
 Paolo Abeni <pabeni@redhat.com>,
 Subbaraya Sundeep Bhatta <sbhatta@marvell.com>,
 Sunil Goutham <sgoutham@marvell.com>
In-Reply-To: <20240625173350.1181194-1-sumang@marvell.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:negLm8hIRqHLISi5v+TCKChejJsRr9zVqJlurIpto4l2SIl8mfQ
 LXQGDBrumdYwIX6BAWQW0eFqHZPUO0KhxhjhJP2fIa4P7JQfh82pGxkFkP2rAnYDj4S0nZG
 6N/MF0BnXdovvsB9Jh8U/RMibuZf2l9CymmDkn3Gh2FVAuMystvEOAWCoy/B7wCK9bYbScB
 a2p+zn2oaKf8T5ujPkEHQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:g/Oqccovltk=;mApRExUZqynZgcopBhXDOUIS4GY
 /UDnbV4CK2S0kH38YLQZxyECN8a6i4gJZMlrqZSQBZsHqnSwNwtebmZXDz/3x65xm0hzR/oN4
 DrEQ9Is1HYmoZukAXrVMIrSrjgkpNL/I9TrswThYd2gxJ3oE4C/SQ6HG+sIWstSb4plklgtJd
 3xYI1DXkDRTZXIamEzxmN6N1KINwVlDsslFwWAI16HDs2YVDwMPGmC8Se4w+PH9w8qMq7RZkL
 jCYmKn7hTiWhw1RZJWN+xpy0Ai47mMTZsTjgk7QB4DeEbAVWI8tiJdkQoPMXdKZo6O8wBqTRh
 Edj1svnpm/zRocHBnsNOou6qUFk5Diqq3s+Nct7Wpc2MWBk+6kuNd7pdcdrxFQJF4k8a0p5A6
 dOMZI5c4lXGNUDYZmGqSsEggxau41C24h0ra5JFcizAGreIZ27cO4va1fb7O9IXL2J+3Z0HEC
 qEXxSZDzRdIYDkX0+rxtf3C9PGY9dGw9U1rjA81y8B0oZ5yAtcROeViJbmue9rcL/bGDVhxsn
 7uantliblg1xXSS52T89V1K09z3t1cY1GLilDhxl6/FbEehuzlhcv/RTHidSjgHLTbXGmSENO
 dvk2Eb4VwrLLA60AvpMAYjeAVNz4Qw1X6zwb8w/TY0Z/VFe2i5ZCmXiYlN0IegJNO8H+209hE
 lVFppbixKRTPr3SO4hXBF1B7aVgRBP05RD0HYPPyMO3XlKZrGAjUSOD0HcgA14kE5z1veUFI8
 bk4oDfFiLwB37W9W251FZpam0MxsGyEXy8+gS51i0qjyIANpx9WxZrC7Wz5ZGlzStE3KoRlOW
 zGtWwiKvd0gDZgEYxBjHDyNv2ztVdHXdfy8vGrfOqOwP0=

=E2=80=A6
>   octeontx2-af: Fix klockwork issue in rvu_npc.c
>
> v2 changes:
>   - Updated description for all the patchsets to address comment from Ma=
rkus
=E2=80=A6

* Why did you not directly respond to the recurring patch review concern
  about better summary phrases (or message subjects)?
  https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/=
Documentation/process/submitting-patches.rst?h=3Dv6.10-rc5#n646

* Would you like to explain any more here which development concern catego=
ries
  were picked up from the mentioned source code analysis tool?

* How much do you care for the grouping of logical changes into
  consistent patch series?


Regards,
Markus

