Return-Path: <netdev+bounces-21496-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E489763B75
	for <lists+netdev@lfdr.de>; Wed, 26 Jul 2023 17:44:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D0CC5281E1A
	for <lists+netdev@lfdr.de>; Wed, 26 Jul 2023 15:44:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6849D26B8C;
	Wed, 26 Jul 2023 15:43:44 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B59826B71
	for <netdev@vger.kernel.org>; Wed, 26 Jul 2023 15:43:44 +0000 (UTC)
Received: from relay.hostedemail.com (smtprelay0017.hostedemail.com [216.40.44.17])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 127C52707;
	Wed, 26 Jul 2023 08:43:35 -0700 (PDT)
Received: from omf14.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay09.hostedemail.com (Postfix) with ESMTP id DC232801FD;
	Wed, 26 Jul 2023 15:43:33 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: joe@perches.com) by omf14.hostedemail.com (Postfix) with ESMTPA id 2B4B53B;
	Wed, 26 Jul 2023 15:43:31 +0000 (UTC)
Message-ID: <11ec5b3819ff17c7013348b766eab571eee5ca96.camel@perches.com>
Subject: Re: [PATCH v2] scripts: get_maintainer: steer people away from
 using file paths
From: Joe Perches <joe@perches.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, 
	geert@linux-m68k.org, gregkh@linuxfoundation.org, netdev@vger.kernel.org, 
	workflows@vger.kernel.org, mario.limonciello@amd.com
Date: Wed, 26 Jul 2023 08:43:30 -0700
In-Reply-To: <20230726151515.1650519-1-kuba@kernel.org>
References: <20230726151515.1650519-1-kuba@kernel.org>
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.4 (3.48.4-1.fc38) 
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Rspamd-Queue-Id: 2B4B53B
X-Stat-Signature: kekwf3boy5oqzgutd3xcrgxyb8zmqfpo
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,FORGED_SPF_HELO,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
	SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY
	autolearn=no autolearn_force=no version=3.4.6
X-Rspamd-Server: rspamout01
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Session-ID: U2FsdGVkX1+72Wd9vEYwCd4qCLZ11+p0SIW+an4W+Ow=
X-HE-Tag: 1690386211-699822
X-HE-Meta: U2FsdGVkX1+UpmbqDRhQT+3wZngmi/dvSPNsMFg4A3BVrNxgZT2Qs75z/BS6gQx5s4JQZdKTYCtnX1LDu0K5hNYg06QJzsP8EFz53UQsqRBlCi4mL+/LiRJVrdQYFpVhkITK8cYKBRGSPOlKj1L12dR6Pev3YbhDU8tryOpiGzW5GxgU4cmbe8OMEsgrfZqT141Islyw7Nr41WcF9FAHbWgYQXC6DEvbSSVL/jCt5CUYUflMFI4+28y1iTkD6uBm8/se5jpMEOkTF3/KTTdCc+ijx/vlixdGJTh5V8JyPxjbIdQJS7+xg4YEpTvPH8ns
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Wed, 2023-07-26 at 08:15 -0700, Jakub Kicinski wrote:
> We repeatedly see netcomers misuse get_maintainer by running it on

newcomers

> Print a warning when someone tries to use -f and remove
> the "auto-guessing" of file paths.

Nack on that bit.
My recollection is it's Linus' preferred mechanism.


