Return-Path: <netdev+bounces-14147-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B3C773F3DF
	for <lists+netdev@lfdr.de>; Tue, 27 Jun 2023 07:15:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C6F24280E2A
	for <lists+netdev@lfdr.de>; Tue, 27 Jun 2023 05:15:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB6B31396;
	Tue, 27 Jun 2023 05:15:32 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB5A6EDA
	for <netdev@vger.kernel.org>; Tue, 27 Jun 2023 05:15:32 +0000 (UTC)
X-Greylist: delayed 335 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 26 Jun 2023 22:15:27 PDT
Received: from relay.hostedemail.com (smtprelay0015.hostedemail.com [216.40.44.15])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D4C31734;
	Mon, 26 Jun 2023 22:15:27 -0700 (PDT)
Received: from omf11.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay07.hostedemail.com (Postfix) with ESMTP id B349A16081C;
	Tue, 27 Jun 2023 05:09:50 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: joe@perches.com) by omf11.hostedemail.com (Postfix) with ESMTPA id 846C12002D;
	Tue, 27 Jun 2023 05:09:47 +0000 (UTC)
Message-ID: <7c9690c70c89aac590de139766b5be3bc9162725.camel@perches.com>
Subject: Re: [PATCH net-next v2 1/4] s390/lcs: Convert sysfs sprintf to
 sysfs_emit
From: Joe Perches <joe@perches.com>
To: Alexandra Winter <wintera@linux.ibm.com>, David Miller
 <davem@davemloft.net>,  Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
 <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>
Cc: netdev@vger.kernel.org, linux-s390@vger.kernel.org, Heiko Carstens
 <hca@linux.ibm.com>, Thorsten Winkler <twinkler@linux.ibm.com>, Jules
 Irenge <jbi.octave@gmail.com>, Simon Horman <simon.horman@corigine.com>
Date: Mon, 26 Jun 2023 22:09:46 -0700
In-Reply-To: <20230621134921.904217-2-wintera@linux.ibm.com>
References: <20230621134921.904217-1-wintera@linux.ibm.com>
	 <20230621134921.904217-2-wintera@linux.ibm.com>
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.3 (3.48.3-1.fc38) 
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Stat-Signature: eirzumqgfygyyrq7tdyz5x8ec17s86x1
X-Rspamd-Server: rspamout04
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,FORGED_SPF_HELO,
	RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE,
	UNPARSEABLE_RELAY autolearn=no autolearn_force=no version=3.4.6
X-Rspamd-Queue-Id: 846C12002D
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Session-ID: U2FsdGVkX1+UlTz8Y1Y/SRQgUNG2scYIhZ3r6zhBXuI=
X-HE-Tag: 1687842587-193108
X-HE-Meta: U2FsdGVkX1+XIntmyHlManxmIgRJyEzIipNGHob23LeNoeBwCf86ZTKfA1HdPhLctu1EkGId3ZDBJYiDD1rns9JBc7hBvFePDwQYt2rfk/Q5GSIzdr3KkP157TdjZZhafX3wJ52HOwduiTd5sRV5C4q0CvNMKLxJ9rm2J6IrX4Rf0kPYD+D6bnFZHpFxuIa68J8lyd2ekNdjYYXtt4IPSR9btg2ZgT1ul51ZBQaE79M3psEB0Ae4/o/hTRZ4pNDnju0hL+JoIIenXOW6ykJwwiV60ww770uq4xmtzxCf8BGHAmZxiBc5PoqIkfjlA8GZ0WpkWBMP8ebRBvTzJyb9gy+33pXHye6n
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Wed, 2023-06-21 at 15:49 +0200, Alexandra Winter wrote:
> From: Thorsten Winkler <twinkler@linux.ibm.com>
>=20
> Following the advice of the Documentation/filesystems/sysfs.rst.
> All sysfs related show()-functions should only use sysfs_emit() or
> sysfs_emit_at() when formatting the value to be returned to user space.
>=20
> While at it, follow Linux kernel coding style and unify indentation
[]
> diff --git a/drivers/s390/net/lcs.c b/drivers/s390/net/lcs.c
[]
> @@ -1901,14 +1901,14 @@ lcs_open_device(struct net_device *dev)
>  static ssize_t
>  lcs_portno_show (struct device *dev, struct device_attribute *attr, char=
 *buf)
>  {
> -        struct lcs_card *card;
> +	struct lcs_card *card;
> =20
>  	card =3D dev_get_drvdata(dev);
> =20
> -        if (!card)
> -                return 0;
> +	if (!card)
> +		return 0;
> =20
> -        return sprintf(buf, "%d\n", card->portno);
> +	return sysfs_emit(buf, "%d\n", card->portno);
[]
> @@ -1970,7 +1971,7 @@ lcs_timeout_show(struct device *dev, struct device_=
attribute *attr, char *buf)
> =20
>  	card =3D dev_get_drvdata(dev);
> =20
> -	return card ? sprintf(buf, "%u\n", card->lancmd_timeout) : 0;
> +	return card ? sysfs_emit(buf, "%u\n", card->lancmd_timeout) : 0;

Like the other show function
I think it'd be nicer to use:

	card =3D dev_get_drvdata(dev);
	if (!card)
		return 0;

	return sysfs_emit(buf, "%u\n", card->lancmd_timeout);


