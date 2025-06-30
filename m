Return-Path: <netdev+bounces-202369-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F1FECAED934
	for <lists+netdev@lfdr.de>; Mon, 30 Jun 2025 12:01:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 021261898619
	for <lists+netdev@lfdr.de>; Mon, 30 Jun 2025 10:01:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E69F24501D;
	Mon, 30 Jun 2025 10:01:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="FKxpCMPY"
X-Original-To: netdev@vger.kernel.org
Received: from mout.web.de (mout.web.de [212.227.17.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 991251E2858;
	Mon, 30 Jun 2025 10:01:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751277663; cv=none; b=iWecyi3RMaO5yB/uhdt+eb2wNyT0r+uLVioqwXlE4bRoJEciXpy1vxTSLlZY+5nUGwASsPMpdnsVGb4L1UznvbBXmnkY4hqFeJmeM6oenzzw70Ph5AQeDT8DK8LTCbmGWvsrfp9koOodJHgyjOS62qdwfexcLzm38ATpB9ApyZU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751277663; c=relaxed/simple;
	bh=eP/79sG5uEeC7F5/Gqfpy1aZG6Wrq0Aun6AllwdWNPg=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:Subject:From:
	 In-Reply-To:Content-Type; b=j3SK2gYI3nm64M28t2Sx7K5FP+H0VUxomifRwJcLUyeS+Qeu3tS/0QTK2qsJ+J+Nowgetdwsp1uvX+tlucTIdq5IuxlLRI2HzC+A40MvNWsM5GdUIGC0ay/IOE5YTaaz+yTndD2EdBW6rxBprxtlLuYxvwh/TCWgsTcraWU+ebM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=FKxpCMPY; arc=none smtp.client-ip=212.227.17.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1751277641; x=1751882441; i=markus.elfring@web.de;
	bh=kugrVosBTJwA6XoBbQtPkhNHnaFGI7cyFhg63KcNtLY=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:Cc:References:
	 Subject:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=FKxpCMPYoVdYh3eaHxD/Ry/7xAZ3bWzRAVqgm7uAziKtEjZj1c8jqKYysasM9cxx
	 5EazAQBtCzavGtQ70VkHs1jdSExG4RdwGIYQcGug8OR9l61BtCc/AnaaPAmVMnrmQ
	 gDCbXrff617fZAYnCAOa/wWUeEQkbm/0JcWazDveWMnIFBqPfmD19PKYdxDleNSUv
	 7WK6aqjFzZ5WlwPwkV7qoJCap7M24d+59pNr0JgAcvozoHEcx2X/IyM/q8tzG/b9H
	 uGa0g/w6f7N2YnkVSBX8RQNVZOXK54Ca8ZwvF5CVRjI2aGL6S3y8X8MXEAlJMevVW
	 Ba6BlPeaE9D1oCAQ9w==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([94.31.69.202]) by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MXoYQ-1uDPSH1Pfo-00OyE9; Mon, 30
 Jun 2025 12:00:41 +0200
Message-ID: <c148ac93-2284-4591-a3a2-3df0e42a6cb1@web.de>
Date: Mon, 30 Jun 2025 12:00:39 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Zigit Zo <zuozhijie@bytedance.com>, netdev@vger.kernel.org,
 virtualization@lists.linux.dev
Cc: LKML <linux-kernel@vger.kernel.org>, =?UTF-8?Q?Eugenio_P=C3=A9rez?=
 <eperezma@redhat.com>, Jason Wang <jasowang@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>
References: <20250630095109.214013-1-zuozhijie@bytedance.com>
Subject: Re: [PATCH net] virtio-net: fix a rtnl_lock() deadlock during probing
Content-Language: en-GB, de-DE
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <20250630095109.214013-1-zuozhijie@bytedance.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:NoTe6grqiAkLrY2As2V9hJ3vMVujTWuhDeyBsjG/3NHc0o+qYAD
 tvt12aMGG94pIq7eBBaome4fDZV5YsDiqfdnXplMYWMthkxDwTkjKA0aFP4gvlQZX1BXbHo
 ZzJ9+IrdyCK9Fb2oaoCs+9XBcGYjaN5A+NIsKDB5B1dZakHaJIgIrTO5oDwyo4kmeAYSkkA
 k9hety3U+Bsf69QoiUBcg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:D7CBCqAQhuk=;3lU83Jvu8zxuMefB5ECwufMxEvk
 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
 US/f6XmHLczXYB7SWSvtMK0=

=E2=80=A6
> Fix it by skip acking the annouce in virtnet_config_changed_work() when
=E2=80=A6

                            announce?

Regards,
Markus

