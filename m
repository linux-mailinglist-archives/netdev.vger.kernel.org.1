Return-Path: <netdev+bounces-48969-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BFDD77F03AE
	for <lists+netdev@lfdr.de>; Sun, 19 Nov 2023 00:57:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 41170280E80
	for <lists+netdev@lfdr.de>; Sat, 18 Nov 2023 23:57:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57E5820315;
	Sat, 18 Nov 2023 23:57:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cEBhBVl1"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 197BC1E508;
	Sat, 18 Nov 2023 23:57:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BEA86C433C7;
	Sat, 18 Nov 2023 23:57:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1700351824;
	bh=hGn1k8/XkatnSDQ8GMUnDRJ29L047zzWy1lubfc7N5Y=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=cEBhBVl1xLvk5oXDeO/hQsnG6k4BMSkng9WgFXyzA6Em+iJBBiZzeRd+eoREKiml+
	 d06lRE2o95iCw2/2hzJfi9vil93N32wNvKiRSlwHAQY0BOw7z5E5PAzQt6wah13/qr
	 jzLQTmjZH4cRjFjjUznCZQ3zgFtkSmeesqlcUgh2aSQ8NRZmSb3+2JkqoEyccxe3RV
	 wqZHR1rMUtQM88jaUrs0a530i3Mqth2y2d4M3/iYYhFGQOdFmJKlF5GIUe5NhhUZTT
	 Y+Ido//Q8rYzKE9kvZlNG7AKP9GPcy0fNPNSUYr4E5VROOBw496GITGuY68RvQNeDj
	 8sE6m6D/B+AMA==
Date: Sat, 18 Nov 2023 15:57:02 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Kory Maincent <kory.maincent@bootlin.com>
Cc: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Jonathan Corbet
 <corbet@lwn.net>, Luis Chamberlain <mcgrof@kernel.org>, Russ Weight
 <russ.weight@linux.dev>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 "Rafael J. Wysocki" <rafael@kernel.org>, Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley
 <conor+dt@kernel.org>, Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-doc@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH net-next 5/9] netlink: specs: Modify pse attribute
 prefix
Message-ID: <20231118155702.57dcf53d@kernel.org>
In-Reply-To: <20231116-feature_poe-v1-5-be48044bf249@bootlin.com>
References: <20231116-feature_poe-v1-0-be48044bf249@bootlin.com>
	<20231116-feature_poe-v1-5-be48044bf249@bootlin.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 16 Nov 2023 15:01:37 +0100 Kory Maincent wrote:
> Remove podl from the attribute prefix to prepare the support of PoE pse
> netlink spec.

You need to run ./tools/net/ynl/ynl-regen.sh

