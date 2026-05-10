Return-Path: <netdev+bounces-286309-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WEfaEmWlAGoqLQEAu9opvQ
	(envelope-from <netdev+bounces-286309-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 10 May 2026 17:33:57 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id E692B504DB5
	for <lists+netdev@lfdr.de>; Sun, 10 May 2026 17:33:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 832633003619
	for <lists+netdev@lfdr.de>; Sun, 10 May 2026 15:33:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B5D738237A;
	Sun, 10 May 2026 15:33:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="qFaSa/ra"
X-Original-To: netdev@vger.kernel.org
Received: from sonic309-20.consmr.mail.ne1.yahoo.com (sonic309-20.consmr.mail.ne1.yahoo.com [66.163.184.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECD153368B6
	for <netdev@vger.kernel.org>; Sun, 10 May 2026 15:33:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.163.184.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778427232; cv=none; b=iCM/XsSwj4ZSw0UwtVIUjyU4XlfD51C/ijiThh0zDmCozfAO0jrmAkrk9R+0Q5SSptJ3gXJAWK+NsT3ZIHH8zNgfw0PHMY8uSqNZg1Tc0rhSLbYs1Y5DP/SfXdzLE1EM7et/+BtSgJL9MWT2dJP7VvxRnzi+bKXuGoiMn7L0LEs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778427232; c=relaxed/simple;
	bh=0XNrj3KVYYAViBnynH2CLdVegqpjuZ0tR6aFNZPM0ec=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VOtUKhnGHxfEGbcnZJMAQw69eOvNbC7Vcm4yisLQ8ZBEO958wCXMjdMBY85zCWbYO92Ni91EJud4sdq9c/5Uqm6fPTS//NqAS+/XjpWvjeP3Dq3qBCr8wkoSAhEFV/Uj5HKp2BeCPrfB+BFiVNOQKM7jB3mLHTPuzfArhag1HdI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=yahoo.com; spf=pass smtp.mailfrom=yahoo.com; dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b=qFaSa/ra; arc=none smtp.client-ip=66.163.184.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=yahoo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yahoo.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1778427230; bh=/GrFhv8KNgfofnsczsBQh4X3Q/PoTxOC9GDrVxhIcn0=; h=Date:Subject:To:Cc:References:From:In-Reply-To:From:Subject:Reply-To; b=qFaSa/raHAsL/3vBUlacjEmsl6o3rfSyzOnLgY/orCkY5ucAXNgUiXcMOtSCDcywVxcQpTzlbmjWdsWVQRVRYO/1pyKsQx4IlGT2T1y0WvNkTprNN56cB01ATA2sM9viA27y9iOZyaflrS2VRVOdb696mSLb/KTyM+5uYjJbNlbBG/Ay+zy3Iov9VWbLXsawHU4v2GbQzJihdccxholfOkqOhbPWEBFDJjDIKL5WoRzq1mhnvUvJWwBbZiqaK0LSOhwZrr9p0ZNwq3HVRJj61kTn7rx4sXtUPKtw1Icoz62rW0uq2DRXBgqEfU3Wql1jPOIG9ChjcEruBY+06KITWQ==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1778427230; bh=e7Z2MGFHdt5D9icYSKsGFr8tD7XukYul4I91MtcItbn=; h=X-Sonic-MF:Date:Subject:To:From:From:Subject; b=ow1ekIUUp6ib13do0ON6KwdnHfF52lPOlEHyy50V6gXtXTAFYbR1vTHixhqU7sG+2PSc+Vg3Ok1EbX5piz8QoeMwkmMsW0xu3fGB7KpGa+K2lYXelQJSN5O7lOd1CsErzcTqick9Zz1rAl0jCjugg90MvD0NcSv7BQ1R4gbqH4hohNd+6OT1P4LypZfXduDdELVPoy4x8Rbn1Gtga+yVZpG9X3BGWMc40b6QvpQFKgX67Q+IuCcjutQlELJHQFpMRfHcQsYK/4+JTtBWa89ifVPj4/20rYQdvrmmHVgnkRSv8GRKQL5BeBSrhcqZjDkcKBLpSpVuZmQzm1zsFOttGA==
X-YMail-OSG: CxemiO4VM1kvExZkKL.bNhoKKEVax4OXuV9nOQlLgV5THNzu6tjNIpaKbypPgdu
 OpyY0j1PE5XVQqwrwniBn0IVPbCRilqt6KDWjvsg68G8EG9rhsOMD7uUq4Ht.hIdZIMl59Lc3Pdw
 Kwz_hvXz5EN3J9iqvuC6.Z4bXcwLUp4Rtr.mtm.7fpmcEBsWjFmUMZxB38guwVHMvkQvx_THMgF5
 2k9WgmJCYVOgdGWGffLUYKTjh5zuD8ZcsNu4sewXqeC3EL7VMsttBotGZVmjfZ3TivIo5vzjH8cZ
 7tgPdDBdc3uasUoykUwerTQ6LrianDcKp40Js5kGEpTEK3YMkGJGTgxDnCA8dUtQHPLlzcxz9_ZM
 9VnmO.xrBNmKZX3cyc5gBrfa2KEYefULZs2btmErJD14s4vUkWRmOPv0zscpfB7.zaFqpZcGmhZo
 j0aG_LT9utw5fZ3X7643EUWhWdXB4.tpmn7lFOKzrQJHCLrPjftulQMKktmu2oc2WE8Z6ZhbhSY_
 A7YXCWi.oTnj.6pdGVD7QQ46wyJ4GeAIYT0KJaowFStPbddrXlTU0g5lYGfgTsK2OA4DxPsoeiBt
 fzPWarL.DounMrgom2VLg_JQIY1d_JIpiKT_5DxbnuCZy7nDZi30y7rU_ePuyExc8rJahJvQmELc
 MjxHcd58A1ji.pXhQhNqmmr_duPKf3jlPs9fl0hNJY30jczk3X54tW8MGKK2Y8bMtcjpHTGxJK99
 XHWK4vSLGSlxp18_eb8QKJifm9GlAzXHUrydRZ1OBphWNgQqFBUK7cfBP8rCRTNxIyrO068Z2X2l
 UMrB.EWk7ydJRgzUJ1RLJ4pI5Te4KbVRK72ctvO1mUnRj.HLhGDJXMl7_qQssrqcpkPYRss2hWA_
 IrgHfKsCkqzO.RAo.YoKwRyiqAU9VlUZhPWqwPGMwI9UZ9LWUsFv8sqnqdnZFKFPlX9C838A.RTQ
 L4M7epZND4nNB6tz6x5Or.DDQqUzTgFMf8Pwjb09r0q9ppM1ZNA.6Hp9xrMrmE7S1pp43h1Ajjf3
 STgZirWNdDAW2z.hVk9DbebyPQXag_cRA_JnJ9K.uyYUwbpH1m9.0b757XGv3kRd5z92P2mDteNA
 MLEt6pKk0JzrDt_PFlmHhpGNOeO2n6l6gZGF9PebE.42jB7NECFMRBdZvBMfgWQ7St6sWwcNRxPL
 _Ji80VnY8Jz81n8Upss.q4SJMy3XSWTUyzbcQ7Etieowx9BzVooySofEdurd_T4w2iuy1O0RjiCj
 k1zU9p1Zr3QyJW90Xr4pkVc775eXcQ7v5riBt7GaNQM26tipqFRTHN3PvGNOJEz_9fdoB.6CCG6d
 KXSRxqEXG_NadEVwiExyD8590PcVyYG_pTlcOWKyD5_rAjuTI_ceM3ZhPMpYNldJB9a5eAwFvfXc
 nEG5Wq1na1GuQIFpzDw72VbVWGBAZJ.W3tqFXoP5EHcwd37Cq7IsfpEOhdbBWMgRUl0geix35S37
 72Rp6rRNRxYjFxsoLzaZ1adBxuzBytiIaJMvbGyve0elbpjBXGXhtEOVZCtMurvBQ.yc8dcV4Yz6
 3QsEijWk9MDS.4NktNW31v._uMledIWzAmxnyT1atO8NnB0duOjYTYLvbYF6wHimrRtV3jKymGtX
 CnxIihdYvFtMkkRvYybB4.pJbyPODIze8snC39UrszatpOmd3xF_QAVNO6VmRq4gwsODzlQ9ggKF
 ojIM5QZqVEjp3GgY.6zQeFFKgXuj2fyt474RmVU85qbOBMo7MI.wSBJQzQUrBWpVzsv4Q2hAH8cr
 a.R4Y8iSchzg7RN59RcAVei4scSE3YHS0BrYrqwKP9lfZLIuYCA97n_XRSRvcUwjxDy4W0cD16A1
 4qjn_mw3xEvsbDEQmxEyYMBvyb8GgZLTFDXM_PxjYdLrValCymSjtKeKugIyH3KWkqJJKa2pbG4g
 yUfU7kZCJg1P7MetOhZMFQL_eF6xjxq.S8OPvzAYL8t22iBSiGR0RIhDjPDxqIRKRbBATkFFPbA_
 uvUXby8Ms2Dx2xytDNLlzbwerTQcb4MDIRof1iIGQqkULnkVmyV9TQ0LkJTkBT2b93yeVmRU4Eji
 XG9vmqqNSFz.NICeolDXUtVHvDj_wV2Krybk_rTg2mAu1ur4oEOyDU5fCWFdA2kLsveiVb77PyQM
 CizMJ54PGGQjdjZTYzeppVE7LMwrbFf3Xfzmf89DB0Crr5Tho3lUrcjpAKfqboYtWzcCXxsLZrOu
 pllfZqZfJ_1t540lMF49lyzPhyjSGvVOwk0IM3nhS..SDqQPA.meyWvO3HIQ7Gjtyf9i_34SDDL.
 3jiiECenL9xaCdXBGnAO4FYUWtL72ucEvhbMytMXMenCfgSs-
X-Sonic-MF: <namiltd@yahoo.com>
X-Sonic-ID: 438b7af0-e302-4e68-bfc4-cf4caf84b5d1
Received: from sonic.gate.mail.ne1.yahoo.com by sonic309.consmr.mail.ne1.yahoo.com with HTTP; Sun, 10 May 2026 15:33:50 +0000
Received: by hermes--production-ir2-89844b765-pm5kn (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID c03192a3bb317eb6d5227ddfdbf19791;
          Sun, 10 May 2026 15:23:30 +0000 (UTC)
Message-ID: <37aab627-b1e4-47ae-9b51-96b7e51f6b81@yahoo.com>
Date: Sun, 10 May 2026 17:23:27 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [net-next PATCH v3 2/8] net: dsa: realtek: rtl8365mb: use dsa
 helpers for port iteration
To: Luiz Angelo Daros de Luca <luizluca@gmail.com>,
 Andrew Lunn <andrew@lunn.ch>, Vladimir Oltean <olteanv@gmail.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Simon Horman <horms@kernel.org>, Linus Walleij <linusw@kernel.org>,
 =?UTF-8?Q?Alvin_=C5=A0ipraga?= <alsi@bang-olufsen.dk>,
 Yury Norov <yury.norov@gmail.com>,
 Rasmus Villemoes <linux@rasmusvillemoes.dk>,
 Russell King <linux@armlinux.org.uk>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 Abdulkader Alrezej <abdulkader.alrezej@gmail.com>
References: <20260506-realtek_forward-v3-0-1d87c5f85a3b@gmail.com>
 <20260506-realtek_forward-v3-2-1d87c5f85a3b@gmail.com>
Content-Language: pl
From: Mieczyslaw Nalewaj <namiltd@yahoo.com>
In-Reply-To: <20260506-realtek_forward-v3-2-1d87c5f85a3b@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Mailer: WebService/1.1.25725 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo
X-Rspamd-Queue-Id: E692B504DB5
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[yahoo.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[yahoo.com:s=s2048];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-286309-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,bang-olufsen.dk,rasmusvillemoes.dk,armlinux.org.uk];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[yahoo.com];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com];
	RCPT_COUNT_TWELVE(0.00)[16];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[namiltd@yahoo.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[yahoo.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Action: no action

On 5/7/2026 4:58 AM, Luiz Angelo Daros de Luca wrote:
> Use dsa_switch_for_each_*() whenever possible.
> 
> For port setup(), a new blocking setup phase was added for all ports,
> including unused ones, before the user and CPU port setup.
> 
> CPU isolation now includes all user ports as traffic was being blocked in
> some scenarios (suggested by Abdulkader Alrezej).
> 
> Suggested-by: Abdulkader Alrezej <abdulkader.alrezej@gmail.com>
> Reviewed-by: Linus Walleij <linusw@kernel.org>
> Signed-off-by: Luiz Angelo Daros de Luca <luizluca@gmail.com>
Reviewed-by: Mieczyslaw Nalewaj <namiltd@yahoo.com>

