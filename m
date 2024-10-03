Return-Path: <netdev+bounces-131671-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B1CDC98F369
	for <lists+netdev@lfdr.de>; Thu,  3 Oct 2024 18:01:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7046B282413
	for <lists+netdev@lfdr.de>; Thu,  3 Oct 2024 16:01:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E78A1A4E78;
	Thu,  3 Oct 2024 16:01:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="MGtF0T7W"
X-Original-To: netdev@vger.kernel.org
Received: from mout.web.de (mout.web.de [217.72.192.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B37A71A4E77;
	Thu,  3 Oct 2024 16:00:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.72.192.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727971261; cv=none; b=I7gDF29ExkC1rM/QC/j6vukEBut1jjKG3ofikt/KvYHLNfogEPDrHFzh5N5A5g+YPrJDER9QEJ2OFkepPok+C5vYOznpL773nNxmaObn6kNj2d87QZskPhjfz2QWKEeruhkNuq9+/4400NPbMfC00wkiKZjMa9Lctpm51XVRW5Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727971261; c=relaxed/simple;
	bh=US268CN7C8u8I8vi+t39s6ixvSRPzyOJbZ9UOyWWhUA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WLuIaNQEobM73kR09Q0nrAlehjg3if8CLoASzbJ2NZcV89vWYJL/m8fXBmk2uEq/q2ZAW4bwY+4UUJ8SMt9VP4nLiqdv673zDPCms+cF10LdM08R8me92lAt5+ejT5nsmyD2TVKxbdIFleYK5G0pxrB1vFph+xS3hOESPL8bxbk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=MGtF0T7W; arc=none smtp.client-ip=217.72.192.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1727971223; x=1728576023; i=markus.elfring@web.de;
	bh=mgi1PA9iSNuOGfuY2GvmlRhWbak0YrTiX689gvSw+fo=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=MGtF0T7WLniRYu2vrmZhSVNZLiNqyYqmj+nNdxvf1AjAFzIt2aa6zMHe+GcKa+xj
	 F247iC+VdeUjaH1LUUpyeOOGuCh0utCcCQvM47zUUIMjITHIhO4mb00QpMVXOxjrD
	 gbwQiKzpCtO8M4M4P/k0W2AUQApU0bSTPPkWF81/+vwSSZENln/HCuk3oLp/iOd0/
	 HbjzMXr47RCXMZbi4r0omLK0ygdHdsmsRUdE5ZY6O2ya2UdIVkHTFmkIUDsY01gCs
	 2U4KBD2MDVDI8y7gHi6WxouWdt9PYOxZgWBUWQrRJTYzQeRlCK1yvnnGXKWu0mK3i
	 3el0ftrdZKmnLgyigw==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.87.95]) by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1Myf3v-1ry4KI0tbB-00wE6x; Thu, 03
 Oct 2024 18:00:23 +0200
Message-ID: <c7844c93-1cc5-4d10-8385-8756a5406c16@web.de>
Date: Thu, 3 Oct 2024 18:00:21 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] cleanup: adjust scoped_guard() to avoid potential
 warning
To: Andy Shevchenko <andriy.shevchenko@intel.com>,
 Przemek Kitszel <przemyslaw.kitszel@intel.com>,
 kernel-janitors@vger.kernel.org
Cc: LKML <linux-kernel@vger.kernel.org>, netdev@vger.kernel.org,
 =?UTF-8?Q?Amadeusz_S=C5=82awi=C5=84ski?=
 <amadeuszx.slawinski@linux.intel.com>,
 Dan Carpenter <dan.carpenter@linaro.org>,
 Dmitry Torokhov <dmitry.torokhov@gmail.com>, Kees Cook <kees@kernel.org>,
 Peter Zijlstra <peterz@infradead.org>,
 Tony Nguyen <anthony.l.nguyen@intel.com>
References: <20241003113906.750116-1-przemyslaw.kitszel@intel.com>
 <63de96f1-bd25-4433-bb7b-80021429af99@web.de>
 <Zv6RqeKBaeqEWcGO@smile.fi.intel.com>
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <Zv6RqeKBaeqEWcGO@smile.fi.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:S/T1X299wtUxa7pi41Mplw3q1ZNcg+4TUXsquBhiQxPHy/qrgcc
 tPz0bDFKZLZhCLyHxntMWYbCdf6CAXlutSBJLIQ1EFAEmmuqfoilE+FWkSC7Ud1nsTJn9km
 8wPxqjQ+L/jI746B/lNFQ2FY5mabp7ncctqrJZTmKSS2o1qh+kVzp+Alo1c4Kj93+bUOf2B
 OwogGPo7OL3Ed0y9cqXDg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:J7MJisWnq58=;MzSjKpS9joyZnLLpnb4Iyi5ZmJy
 k3zs7FxiSw5tTfQcXPK0zoL59OBAjsa5IdKXXfYLQ0vLJIkz7yQGb8IRtLfRZF4biM9nqA6TQ
 NQRI7JkiLN7o4d0wk84veOQXHzBv24Dyx6Yp57CjPbwNotLU+3ewKAsSQvGmqd+dl/EcdXvwN
 XZtcGAZDCI0BtE0WCUzGGr0oxQk3Xlh7mRG8crDp7OedLRRA/FG4exM0I4DUg6M5lVhNmUql6
 RNWqF5W0ltCByVDL8D2uG1nf/PMUkOdHmaSkCp5kwirDa2JrxCWfKBz6Hinp8/XlOICCR7rHg
 2e4VFr2PP0DFw3T2aw9Uzt2XrS5EKyLptZpEhwXoMyi8RDvdKGeePrRCCf11GuClZvPveapyM
 K/3zNK4LzPk8+yfKUAL/4tQK9LhJ9XlL22HoZnyrAAk/bNRtupiyI4Y+1ldr9bl8khE9Du+TD
 FLln+Q29Aua5xoauZcmyssO8+X4YtoCcOb0aa6gEK40fIguCyrUAJdujxFdxae59NwV8dTqFm
 0befEyvPyIYWgu2Odxg7ULboNZOyTYcoajjODpWNh2d5NcWVKsSe0bG/hLpe9h6T4MvBGCOq/
 RjQ1TCQeNYtC2LJGaIqR8p9Z2CZd22yjzz8t7AnZVBcOniBZMX4Ca6zrogR/3dXCRxaxjqFOD
 zkoq3Pb8IypWjzyVVQRRgulzaKWZ0V1vo+LaE20Ekva7XM7WRW5ICb4cpitTqpN20eopoTbF7
 3Z9/4KoEGBdihapjGjHRxN4OGMAD0PGeLzvQU2jvCUIXpF8UsSY9HbdonFTsvlNIJMejs2aw1
 HjoPXeiWekcbRXdMO8GvggBw==

> =E2=80=A6
>
>>>  "__" prefix added to internal macros;
>
> =E2=80=A6
>
>> Would you get into the mood to reconsider the usage of leading undersco=
res
>> any more for selected identifiers?
>> https://wiki.sei.cmu.edu/confluence/display/c/DCL37-C.+Do+not+declare+o=
r+define+a+reserved+identifier
>
> The mentioned URL doesn't cover the special cases like the kernels of th=
e
> operating systems or other quite low level code.
Can such a view be clarified further according to available information?

Regards,
Markus

