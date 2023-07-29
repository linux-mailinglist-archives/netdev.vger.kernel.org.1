Return-Path: <netdev+bounces-22473-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 670DC76796B
	for <lists+netdev@lfdr.de>; Sat, 29 Jul 2023 02:22:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 73E1A1C2192C
	for <lists+netdev@lfdr.de>; Sat, 29 Jul 2023 00:22:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30C4C37E;
	Sat, 29 Jul 2023 00:22:44 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25BD4198
	for <netdev@vger.kernel.org>; Sat, 29 Jul 2023 00:22:43 +0000 (UTC)
Received: from relay.hostedemail.com (smtprelay0013.hostedemail.com [216.40.44.13])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 616602680;
	Fri, 28 Jul 2023 17:22:42 -0700 (PDT)
Received: from omf10.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay02.hostedemail.com (Postfix) with ESMTP id 9B12312061F;
	Sat, 29 Jul 2023 00:22:40 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: joe@perches.com) by omf10.hostedemail.com (Postfix) with ESMTPA id 9739432;
	Sat, 29 Jul 2023 00:22:37 +0000 (UTC)
Message-ID: <a19576f73036e772225140bb54f433caf0097e4f.camel@perches.com>
Subject: Re: [PATCH v2] scripts: get_maintainer: steer people away from
 using file paths
From: Joe Perches <joe@perches.com>
To: Konstantin Ryabitsev <konstantin@linuxfoundation.org>, Andrew Lunn
	 <andrew@lunn.ch>
Cc: Jakub Kicinski <kuba@kernel.org>, Linus Torvalds
 <torvalds@linux-foundation.org>, Krzysztof Kozlowski
 <krzysztof.kozlowski@linaro.org>, geert@linux-m68k.org, 
 gregkh@linuxfoundation.org, netdev@vger.kernel.org,
 workflows@vger.kernel.org,  mario.limonciello@amd.com
Date: Fri, 28 Jul 2023 17:22:36 -0700
In-Reply-To: <20230728-egotism-icing-3d0bd0@meerkat>
References: 
	<CAHk-=whCE9cWmTXu54WFQ7x-aH8n=dhCux2h49=pYN=14ybkxg@mail.gmail.com>
	 <20230726130318.099f96fc@kernel.org>
	 <CAHk-=wjfC4tFnOC0Lk_GcU4buf+X-Jv965pWg+kMRkDb6hX6mw@mail.gmail.com>
	 <20230726133648.54277d76@kernel.org>
	 <CAHk-=whZHcergYrraQGgazmOGMbuPsDfRMBXjFLo1aEQPqH2xQ@mail.gmail.com>
	 <20230726145721.52a20cb7@kernel.org> <20230726-june-mocha-ad6809@meerkat>
	 <20230726171123.0d573f7c@kernel.org>
	 <20230726-armless-ungodly-a3242f@meerkat>
	 <1b96e465-0922-4c02-b770-4b1f27bebeb8@lunn.ch>
	 <20230728-egotism-icing-3d0bd0@meerkat>
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.4 (3.48.4-1.fc38) 
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Rspamd-Queue-Id: 9739432
X-Stat-Signature: 7gkuanj5xoc7qcjfcfz36obxgeao5xs4
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,FORGED_SPF_HELO,
	RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,
	SPF_NONE,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=no
	autolearn_force=no version=3.4.6
X-Rspamd-Server: rspamout01
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Session-ID: U2FsdGVkX1/mOlvdfqFchiId5QJNtKS3kzhjO8vsu4s=
X-HE-Tag: 1690590157-822710
X-HE-Meta: U2FsdGVkX1+FNPSwB11j+R1wv5Pxe7vaiubW5Wi1tA+AoCaaqbhADgPa2JldVgvi5mt27T8OmwOyKQxChZuxVniWz70LwwPoYgW26IU9AbNFvBrSIh4SlJBrqRhFksqSA3bOCkUMWppnpofJV7wsu8AHEmyvRtyc9jLQWnZkbBfHiHihBeyh8XvyAlG/Ir6eSWq0Ohs+VstIxoVmS7OPIfvMQxSMbzCRM71dnHHqbmISNhdjpTLUK5ztQeQyr64Pxdq8q0X9tNDSs+MsiwPDl74QyrF71UABKIeckzzZhGqXfsKbqfP7Uiy41EVDg1VnDULDt4fiB2MVPenvPk78HSflzxegK8s736AuJOdUBchWDnYWqk83m01FrWt9wJSM
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Fri, 2023-07-28 at 16:29 -0400, Konstantin Ryabitsev wrote:
> On Thu, Jul 27, 2023 at 01:00:15PM +0200, Andrew Lunn wrote:
> > > Think as if instead of being Cc'd on patches, they got Bcc'd on them.
> >=20
> > And how does reply work? I assume it would only go to those in To: or
> > Cc: ? Is there enough context in the headers in a reply for the system
> > to figure out who to Bcc: the reply to?
>=20
> I have actually solved a similar problem already as part of a different
> project (bugbot). We associate a set of additional addresses with a threa=
d and
> can send any thread updates to those addresses.
>=20
> It would require a bit more effort to adapt it so we properly handle boun=
ces,
> but effectively this does what you're asking about -- replies sent to a t=
hread
> will be sent out to all addresses we've associated with that thread (via
> get_maintainer.pl). In a sense, this will create a miniature pseudo-maili=
ng
> list per each thread with its own set of subscribers.
>=20
> I just need to make sure this doesn't fall over once we are hitting
> LKML-levels of activity.
>=20

How about whenever a single mailing list like
	linux-patches@vger.kernel.org
gets new 0/n without an in-reply-to header and m/n patches with
only the single in-reply-to header of an 0/n patch or simply a
single patch without an in-reply-to header, the cc list is
automatically generated from a tool like get_maintainer and a
From: <sender> line is added if necessary to the message body
and the email forwarded to all cc's and linux-patches is removed
from the email?

I believe that would help solve most correctness of recipient
list issues and then the linux-patches list would not need
further involvement.


