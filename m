Return-Path: <netdev+bounces-37698-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E9EF7B6AC5
	for <lists+netdev@lfdr.de>; Tue,  3 Oct 2023 15:42:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sv.mirrors.kernel.org (Postfix) with ESMTP id DBA6228166E
	for <lists+netdev@lfdr.de>; Tue,  3 Oct 2023 13:42:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 754542940E;
	Tue,  3 Oct 2023 13:42:20 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66A9B266AD
	for <netdev@vger.kernel.org>; Tue,  3 Oct 2023 13:42:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 68F7AC433C7;
	Tue,  3 Oct 2023 13:42:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1696340539;
	bh=HvH1Q1z92W9hdqkCNnVvSV1dvkn66o/wVbN4IpbbyWo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=grYxISXlNYov8M8r0twN1gillga5LQqMIC24ujlJP/o8k/u0/3PpkWscYWy4n4AEK
	 PsK3V+Cd46gw2XaSa9kOWFdHRop1w9xqBpaSBSQ5V1aZ8BGeX//N48ROpmy4mm7ic5
	 0qM0lbJoGLqG5je2PqIQRNaXeuUOd36yALjX5obugnCRK+U3xU9DwZA1StdtEtC3US
	 SegqiqX/LaBsRtxX68KlsDlKrRkSRKFhBwOvTI5oqDCYLe/ISNZrzrmMJxbp9k+94F
	 jVwurMYMNfLAzBAjr6bD8nGpsYiUj9RAkSs/LuDIF7mZAHwwqMfwAENFh0D3lEESpj
	 lQ5IY7xOndrOA==
Date: Tue, 3 Oct 2023 06:42:13 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Lukasz Majewski <lukma@denx.de>
Cc: Vladimir Oltean <olteanv@gmail.com>, Andrew Lunn <andrew@lunn.ch>,
 Woojung Huh <woojung.huh@microchip.com>, Tristram.Ha@microchip.com, Eric
 Dumazet <edumazet@google.com>, davem@davemloft.net, Oleksij Rempel
 <o.rempel@pengutronix.de>, Florian Fainelli <f.fainelli@gmail.com>, Paolo
 Abeni <pabeni@redhat.com>, UNGLinuxDriver@microchip.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 net-next 0/5] net: dsa: hsr: Enable HSR HW offloading
 for KSZ9477
Message-ID: <20231003064213.4886626f@kernel.org>
In-Reply-To: <20231003145106.3cd5a19f@wsk>
References: <20230922133108.2090612-1-lukma@denx.de>
	<20230926225401.bganxwmtrgkiz2di@skbuf>
	<20230928124127.379115e6@wsk>
	<20231003095832.4bec4c72@wsk>
	<20231003104410.dhngn3vvdfdcurga@skbuf>
	<20231003145106.3cd5a19f@wsk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 3 Oct 2023 14:51:06 +0200 Lukasz Majewski wrote:
> I've just noticed that there is a WARNING:
> https://patchwork.kernel.org/project/netdevbpf/patch/20230922133108.2090612-6-lukma@denx.de/
> 
> but then on the newest kernel checkpatch.pl is silent:
> ./scripts/checkpatch.pl
> 0005-net-dsa-microchip-Enable-HSR-offloading-for-KSZ9477.patch total: 0
> errors, 0 warnings, 0 checks, 277 lines checked
> 
> 0005-net-dsa-microchip-Enable-HSR-offloading-for-KSZ9477.patch has no
> obvious style problems and is ready for submission.
> 
> Does the checkpatch for patchwork differs in any way from mainline?

We run:

checkpatch with --strict --max-line-length=80

https://github.com/kuba-moo/nipa/blob/master/tests/patch/checkpatch/checkpatch.sh

The "multiple new lines" warning on patch 2 looks legit, no?

