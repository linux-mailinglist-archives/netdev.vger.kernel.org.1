Return-Path: <netdev+bounces-21527-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ADD9D763CF3
	for <lists+netdev@lfdr.de>; Wed, 26 Jul 2023 18:51:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 628481C208E9
	for <lists+netdev@lfdr.de>; Wed, 26 Jul 2023 16:51:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B0121AA76;
	Wed, 26 Jul 2023 16:51:35 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BBD31AA61
	for <netdev@vger.kernel.org>; Wed, 26 Jul 2023 16:51:34 +0000 (UTC)
Received: from relay.hostedemail.com (smtprelay0010.hostedemail.com [216.40.44.10])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C41CBDA;
	Wed, 26 Jul 2023 09:51:33 -0700 (PDT)
Received: from omf16.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay08.hostedemail.com (Postfix) with ESMTP id 1E092140213;
	Wed, 26 Jul 2023 16:51:32 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: joe@perches.com) by omf16.hostedemail.com (Postfix) with ESMTPA id 1198820013;
	Wed, 26 Jul 2023 16:51:28 +0000 (UTC)
Message-ID: <dd18599fb75350b0b359134f5b43625fb9208943.camel@perches.com>
Subject: Re: [PATCH v2] scripts: get_maintainer: steer people away from
 using file paths
From: Joe Perches <joe@perches.com>
To: Linus Torvalds <torvalds@linux-foundation.org>, Jakub Kicinski
	 <kuba@kernel.org>
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, 
	geert@linux-m68k.org, gregkh@linuxfoundation.org, netdev@vger.kernel.org, 
	workflows@vger.kernel.org, mario.limonciello@amd.com
Date: Wed, 26 Jul 2023 09:51:28 -0700
In-Reply-To: <CAHk-=wjEj2fGiaQXrYUZu65EPdgbGEAEMzch8LTtiUp6UveRCw@mail.gmail.com>
References: <20230726151515.1650519-1-kuba@kernel.org>
	 <11ec5b3819ff17c7013348b766eab571eee5ca96.camel@perches.com>
	 <20230726092312.799503d6@kernel.org>
	 <CAHk-=wjEj2fGiaQXrYUZu65EPdgbGEAEMzch8LTtiUp6UveRCw@mail.gmail.com>
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.4 (3.48.4-1.fc38) 
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Rspamd-Queue-Id: 1198820013
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,FORGED_SPF_HELO,
	RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,
	SPF_NONE,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=no
	autolearn_force=no version=3.4.6
X-Rspamd-Server: rspamout06
X-Stat-Signature: 8xoc1pa17ewpfstimn3bausji9z3cea9
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Session-ID: U2FsdGVkX188wytRJcomDW0C9fGvXQuLbDZ88wVSRlo=
X-HE-Tag: 1690390288-95582
X-HE-Meta: U2FsdGVkX1/WBFHFsnVkAh3pxIZDJRgtHT5ulI26muZfxzFGDdatyakLeRidqhbVyrBUvzvOcM7I2tdGEhyapEXxJLy711Uy2U6E/M8Hm/c/z3MZSBLhzriU7/9Qzie0HnPatecQDSKyokCOYWasQe5UqFr+Rfdgzfuc9iG7Dnn5e0xyLlTlLCYG2TPpN5tiUnon4KUTqIl4DSbOS+ofCKPU9LaqIO2KuDYpwmOhxevpTAjhhkn7kMavNc3G5J4lyOUeDu/JLb6zeU8COP8cOaxg/oc960weNgjtZxIJ92dlV95XbCCa6YRu0MvB//Mc
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Wed, 2023-07-26 at 09:45 -0700, Linus Torvalds wrote:

> So the whole "use of get_maintainers is only for patches, and we
> should warn about file paths" is insane.

Agree.


