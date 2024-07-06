Return-Path: <netdev+bounces-109636-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 23B8B929437
	for <lists+netdev@lfdr.de>; Sat,  6 Jul 2024 16:49:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 549581C21176
	for <lists+netdev@lfdr.de>; Sat,  6 Jul 2024 14:49:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2408413A87C;
	Sat,  6 Jul 2024 14:49:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="Xoh5xWOc"
X-Original-To: netdev@vger.kernel.org
Received: from mout.web.de (mout.web.de [217.72.192.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47C0913A86C;
	Sat,  6 Jul 2024 14:49:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.72.192.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720277356; cv=none; b=FbMyQX+RQdkmAYP5aYUi3oQ2/YQBzKcuxfjhr6ttePdn9yuwE0lT86nBVy6m+o4kCQnRW8bACp1vRIq1eB/Jro7ZJsM4oiLuK74/Wf13DzbcTZIZsSXH5+hswuAWdr7QirBWktx455oUUo0qRAHs3Exyyg9zdDHiSJKezuH3Rsw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720277356; c=relaxed/simple;
	bh=NLKhHzw2iL4qhzrhvGOTXyRs6loQBaqDJT4atgx9ZAI=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:Subject:From:
	 In-Reply-To:Content-Type; b=aJ0Xfr92Ko3gAMeJFuIfn3LbObpwHqidsUL3PgOnoPGzAfkUAZrbMDTUT0tnEaxKuuBX+cH5rX0+nFOmEiA7MnlgXOAGGrkqsBXW+NDs2dQnfjolbU+GzbRamudHK+5NC6r8ZOgs9gs4x/F7SEVk1aE2l/hd2ixTfkDT5zMo9n8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=Xoh5xWOc; arc=none smtp.client-ip=217.72.192.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1720277326; x=1720882126; i=markus.elfring@web.de;
	bh=Z75ZznpIbvuXtNcDLfumWj2gSi9XkiI5AnYv1mRIAA4=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:Cc:References:
	 Subject:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=Xoh5xWOcip3Q6vPl4p43tJ3b4JWYaS/OxvZeAPKUYvi3JN4CINBU+ZM4lvBdwFKu
	 km1Lx5qTwRhg5abA+PZQ5lyCRFBFww1+AiS+KpNbTjTZ71Iqd+aBWDK/tBaWVj58/
	 m73PejEYPb1fPFE5qyFES7Wq4QP8Q5JwpZNw5pxofLbH6sQcesuFbi9kuIjfXob9f
	 x7+1/8EgpCyQjVoPrz0F5Ry/CEXk55z4JPSNhOJtPd37b5bDzCxNFIS2UqEwQbUug
	 WBbaRfHLeFBAaAe0dKXgFYtvkwq0XgMO65MHQbB4b5R4J/0Amu2LRrHlTItp8f7mN
	 AZEoMWvt5Qv+kS8zpg==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.91.95]) by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MmQcl-1rzbbT1Tc1-00g8Oh; Sat, 06
 Jul 2024 16:48:46 +0200
Message-ID: <63e3f609-69fe-4cfd-8418-eec00705cf32@web.de>
Date: Sat, 6 Jul 2024 16:48:41 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Aleksandr Mishin <amishin@t-argos.ru>, netdev@vger.kernel.org,
 lvc-project@linuxtesting.org, intel-wired-lan@lists.osuosl.org,
 Anirudh Venkataramanan <anirudh.venkataramanan@intel.com>
Cc: LKML <linux-kernel@vger.kernel.org>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>,
 Jesse Brandeburg <jesse.brandeburg@intel.com>,
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
 Tony Nguyen <anthony.l.nguyen@intel.com>
References: <20240706140518.9214-1-amishin@t-argos.ru>
Subject: Re: [PATCH net-next v2] ice: Adjust over allocation of memory in
 ice_sched_add_root_node() and ice_sched_add_node()
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <20240706140518.9214-1-amishin@t-argos.ru>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:sf3LwDMEQp+t08dgcYNRjXtXbVPpC4vwx8LVmzPbHJrnE+iFDn1
 4zBskLf0c2bv3hSGuVVp/cwnjPm1gZ4EDBLQNnEOOauQpbklTf9Fm+i8fYEC05xgIJJRBjM
 weu/5k4C2Y35ffpivJcka07YRt81ilXzy6RDQbBlep5YT/pqduVOGPBkiVniEQrenTRzxoF
 0OA7Egdtz+o1Mf6jAlaDQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:mbw4cSzkPyA=;AqdL42jObrHSi+bdKLMwGFEUY6s
 yaP7sjkWCgnNitUBOFvihU3uMsVDt379O/LzhMoHmEhSgBHxQeRm/yVoC4rKNDBThXnwBTFC/
 EGyqWFCiShb2dAp0YBRRPbb89rEF+Myc2OJ3jt9+YrdaSLTrL+pVjuNwdivjMqfSDI60ynsET
 4l0+u6o4g/N0pgH8eQejtjv5UaxWmxUHc0oOpQVz83zFLdu8GWHOGc6hQkAA/HxlzQZz2TBhW
 NRCfGqm1B0R/Cu4dccn/dEB99C3c9DoXKwpU6JcxpNQS6JkxUoEjoIRbRs2oz21grR73evI11
 J3pRjVsmpFclFFXgi5tmS5HJQpHKWCjIZ6jrJoh+jZX1wlk+7bIVfiQl+mPTpSpvMvHh2HWSK
 N9GoVhg3p1N6F5FxfBh+fKid/+mYQG+VPaQUfdTZquU/hm1FO7zbVgpBdCCnwmEvFhsXeY9oh
 z1LgWvWw9rEPXsK/5UdlFT+gpvpjATIPwEall2KfnoZEMXKl/6vF4APIKTgeU6Nb+ERBlHNBu
 TJqVPukeFYA024hvfnaMu2gF5GV5/8xFXqhVhByjlU/4/Z8kPa9hMLUB6njSTlu2ucnuv0tjp
 yQLf6WuVWfP9bI3n5fA2GCeAHw1b3eBh1AunSz9JKFYzuGrK/SaLp7Q08M8+edSadbkkWStjc
 7GW5YvTxySZ71jGruYAnfEJX+Q4Sgd7IckEmcwj2EagMYJXgM5dIY73q8/DZ9ieY2RsXo5YqJ
 t5/PUtIxYyOqjzt0bRazxlucNa98uxXz/xm0hyOpouy0ElZV87Hx2eJ4LUcupnLXQBl+4rZBp
 Wb/jAwiVFiABU5pa6M7kUPaEFINDec551aDiGRWC5GmHM=

=E2=80=A6
> 'ice_sched_node' structure. But in this calls there are 'sizeof(*root)'

                              But there are calls for?


> So memory is allocated for structures instead pointers. This lead to
=E2=80=A6

                                                of?            leads?

Regards,
Markus

