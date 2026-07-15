Return-Path: <netdev+bounces-307640-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id hIPLL6jtVmpMDAEAu9opvQ
	(envelope-from <netdev+bounces-307640-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 15 Jul 2026 04:17:12 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 1915975A06E
	for <lists+netdev@lfdr.de>; Wed, 15 Jul 2026 04:17:12 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=est.tech header.s=selector1 header.b=kaS2m5r9;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-307640-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-307640-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=none;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D2B70305E3AC
	for <lists+netdev@lfdr.de>; Wed, 15 Jul 2026 02:17:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C9FE26B755;
	Wed, 15 Jul 2026 02:17:10 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazon11013036.outbound.protection.outlook.com [52.101.72.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC138225403;
	Wed, 15 Jul 2026 02:17:08 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784081830; cv=fail; b=Qw/cH+qQWpNMJ62c6SRy1beRktH9WecBRfiDhjT1kqUbo/kXeoHimXZGTlho6uda7lM6T3n4xoa3RDvw9/e31z4JxGMrgRfpE/3b+Zay0IRI0wWDoM1cMD9sbcowNK/b8x9hnrI2msMW6CMMNTtpU1Ii+BXAHW5rI6JNTi1nU7Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784081830; c=relaxed/simple;
	bh=iodbrjEfFqMKBg+dZMlRuVPv/95WNMRIbSVc993iohw=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=HFC6PDWZthvGoLUQqIX2c2hy4gpaxNqiln249qr20hCljD2IHQ2pS2tjfnsUAYxEmQEeE+fJds0TDAIsZxEJeNYDmeR77Tq4Ey9Yb7LL3CR98fsBTciPeX04d7u0egTDZUlfWr07Jaim8/y/eOQYlMa6Jj86HdlPjwP1e1wje5c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=est.tech; spf=pass smtp.mailfrom=est.tech; dkim=pass (2048-bit key) header.d=est.tech header.i=@est.tech header.b=kaS2m5r9; arc=fail smtp.client-ip=52.101.72.36
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jtdU1fa8LP0OlsjhZrEkZsi+/qkG/iQsLOATvxVp6erS8euRMDODzAlLGpF5kHpc4GFUUXvNdPR/LvfnK3OwbzQrWCKoDRmgQ8dLNX21DfbeTZ1tEbCFbaJL5M8TFc/mmTWTGRSe1ZmaiRlS5UxjnH+P0dntUe4CWm3xDZjR46Z0/t1/Jetlbngztr5qVpeFjMv1pPe6H7vN8H+lQnpfJ1lBvJNz9ZX5U9BlOndB13uI/FPQgMY8V8ChCKS49tj1/V9Pgc6aq2nyWJeb+5m1G+iNSFJmpT2CzndCGRuQ4PqoWQw7rkzM3EG227s3e5/LFvVOsFu2OijPtR3CpKGslA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sx+mFhtUOQEGyfSNQIG5TynjvBBZw+w4wkoSY4YxmJ0=;
 b=dcnIQsQz7yrQCEA4ZShDN5yHwW4vYYUELbjnGzwVEm4gCSvgrv2K+BBrTtjGrkJvv4g4n/c8GinOhCpZZ0q4+zr9fe4cH1rni92+yr+q3NobJmOIOtrODAY0WhBIy3blKyEOQWDmjXpOFjD5pDYfucPTCT40O8Dr2wwCDjtE2Z8Za3ilcLcCoD7LbfCMsioC7GiGVFElLkv8xvkLNHMykmbrRqe8w47hJLDZ92Q5NX0ZVLcCBN3a7vfbyN55wGsZM2yfLO/75h3vzB0EZlgCjLAqvYLYw5xys79OtVOFr7AnuTanTJuPYTrcy7f4AiJX4ze1GYy14Q/cRpe5wf6SpA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=est.tech; dmarc=pass action=none header.from=est.tech;
 dkim=pass header.d=est.tech; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=est.tech; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sx+mFhtUOQEGyfSNQIG5TynjvBBZw+w4wkoSY4YxmJ0=;
 b=kaS2m5r9VQI6ggH/Wor63C7EWnvUTY5PA8bUupvf9N89ddcXuQfjbulRh1vJJMO8xcKDwhcmQV6qrWPGEtQ1QCq1eOIEAEsQBbUYFIc2YNtqIh8nqmcM2+EU0J4vYsdW6Dq8zsdt4MBMsLGkB4XmPCOeXk+OepIBVyrD8AbgO80oHpaTW65XZy17AkW0F+bgvLbx8NmadgUwEA44cfyJJuRL7dLgFvGaLd4ItpH8Y27ke5KUkPc6GgpWMG3pWorIy20+DOLs+HBYkjf6en3d79AnhEfrhSvJsUpVyfZqp1lEA3XmieNzQZkQosEIV2wAznuayl2bn6ZC8fL3aADPew==
Received: from DU0P189MB1994.EURP189.PROD.OUTLOOK.COM (2603:10a6:10:3a6::11)
 by DB8P189MB0886.EURP189.PROD.OUTLOOK.COM (2603:10a6:10:16c::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.3; Wed, 15 Jul
 2026 02:17:06 +0000
Received: from DU0P189MB1994.EURP189.PROD.OUTLOOK.COM
 ([fe80::7181:423c:55f1:76d]) by DU0P189MB1994.EURP189.PROD.OUTLOOK.COM
 ([fe80::7181:423c:55f1:76d%6]) with mapi id 15.21.0223.008; Wed, 15 Jul 2026
 02:17:06 +0000
From: Tung Quang Nguyen <tung.quang.nguyen@est.tech>
To: Helen Koike <koike@igalia.com>
CC: "jmaloy@redhat.com" <jmaloy@redhat.com>, "davem@davemloft.net"
	<davem@davemloft.net>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"tipc-discussion@lists.sourceforge.net"
	<tipc-discussion@lists.sourceforge.net>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "kernel-dev@igalia.com"
	<kernel-dev@igalia.com>
Subject: RE: [PATCH net] tipc: fix infinite loop in __tipc_nl_compat_dumpit
Thread-Topic: [PATCH net] tipc: fix infinite loop in __tipc_nl_compat_dumpit
Thread-Index: AQHdEwk3GCZhg7KjeEy6gha5XKvR2bZt2brw
Date: Wed, 15 Jul 2026 02:17:06 +0000
Message-ID:
 <DU0P189MB199424E34AD038D335ABD60CC6F82@DU0P189MB1994.EURP189.PROD.OUTLOOK.COM>
References: <20260713204940.647668-1-koike@igalia.com>
In-Reply-To: <20260713204940.647668-1-koike@igalia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DU0P189MB1994:EE_|DB8P189MB0886:EE_
x-ms-office365-filtering-correlation-id: 053ec53a-98d7-474c-6273-08dee2172aad
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|23010399003|376014|1800799024|366016|38070700021|6133799003|56012099006|11063799006|22082099003|18002099003;
x-microsoft-antispam-message-info:
 B7oaOA+AAnK/QAFSdnWcSpM7smsGgjm0uNOEhodFzJlnl0ZJ2lBhWeca0dvxW1+2xZm6LbcDHqq25kUQHC/oWaqSBSnbu9Wy+D7s/Ei6sgcJ+GG8OwwVWuBYsGKzpC3oMVBxyFKDqJtAX1bfXObxDD8+GHJxTAEYbJJva6sY+s5PuGK+8PtVzjhIynrDyxw9i8bBYUbBfGjdgrd4a7Ls2As5mkM1Psc0sZFblD389MZlgRdHLTagsPRLt0q8UrX9fdkogTSt7/kDzImOeGDn+nfGMUNCQYR+hKX4XfaVzZrP15QqYtqvccEWbgVWqF9zOxJpBk32+Fb2+Ksc88mawDRf+//Kyy0TWgpBXBA5XBkRr728rLbR0M2oRmDniMkGPBo2yc5vblCk97wbwqQcgMDJuKySxej7SOWR0ZCOTCK0tfpNh4DpxOOatTyL3z14Hr5nnbeM2Jbwnh7vxWiedkBH+OBP2qcjObf5Nn/1Zz8TRKE7RVwLsXcdTZkS0/DSfRCLxAQ+TVxpk67CjrzEG6ax1gyf55y/cfBSJHsAm/OkyOH66N+no5ZtD9n99eNqe0FBs1xXUIgjBswFoB/ftv/+T8a1BGgYUTI9tA5iIkjNocWCtf+49zQ0R5qNYv1cCgQnOSZ8AllReodnB5kKpp7UroG2eLW+Z3DSHIjrYPM=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0P189MB1994.EURP189.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(376014)(1800799024)(366016)(38070700021)(6133799003)(56012099006)(11063799006)(22082099003)(18002099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?kgqAUlyn5txgXel+yQvqNTDe/wxODOVKNge+WsRPzK1GAxdIEovA59pg5INo?=
 =?us-ascii?Q?cnG9gJtj4HJnJJ5AEgyXfpdoE6aA+E+aybgVZEEjYvmx8NqYPBWFHhnhvCVG?=
 =?us-ascii?Q?/+zE3i04FAprPWXcQkSox3TqPJHAjAMfEJs/W/lhr2D/RPd7ZzlpyH+9BGqT?=
 =?us-ascii?Q?UHWXfgv75jVNUtXPJo9OEdfjD7eUAz6i8TzpfTavJ2PzYO6BIDq1KcShjQSV?=
 =?us-ascii?Q?+qd+QcKUfMcVIpurslV6hh6h4sUmiaVaFAxesg03dEvZw4XCu3r1k4HzcgVd?=
 =?us-ascii?Q?/A8pHhnXd+w1xMuLf4n70VQ9x6WyPMIOjmgAAd4Y6ClvTBqtDbBrp9Jfm6Rv?=
 =?us-ascii?Q?UD++sj3EjYOKsilimpNIQMyXudHrwy7kmhzE3gzKNxOlYjbZ+ni1+KsUbCYq?=
 =?us-ascii?Q?ybx8YyRXw6stw4waEtbUkMDp+A840JIcoNNYAR/0R1Oh1sAK7DCig6cLX8Ay?=
 =?us-ascii?Q?4X9OyvEEY0O/JOKJb5xz5gN5YuOA7DdsWrMG/FTVIF3mfyX4IbXKV2d/YS4R?=
 =?us-ascii?Q?2f5USxuCsvRvwHQYGx0H1FNuyIDLFWPQapVb+eUyq6O/JbqdOVWt1fz6QgMk?=
 =?us-ascii?Q?Rzlx0J08i3OX5T4HcabF5oTeJ3InwlSJISjMWsIJqdDWGKm0oiVlEQYxEqB9?=
 =?us-ascii?Q?SWD9qZc9GErL6NIlqz/e1csgk62f1BwvkXqz+Fa2Db95F97MsPSi0s8AG1gh?=
 =?us-ascii?Q?NVpPkwcwquT+AxW7La21CDHpDYGLLiyUvZ+DdW5844CvFE3Bh1zvNJJRjIp2?=
 =?us-ascii?Q?yaPRZFXisLmg/udyCO92eEx+dO20G0Neml9o0m4d6yo1mYEr8rXOQ2w8Ccyw?=
 =?us-ascii?Q?0/Tek9WMILzZK9IVS3woyB+JJJfGIGa/PNQljrtRbN3YY8nrxGAjep2d2m9j?=
 =?us-ascii?Q?/T1so1DcDSjzltAsxx3NA4myrHAeY8FS7TJLz1Ch20HZ07AJ2Q8tbVUvSqzw?=
 =?us-ascii?Q?AqIH+WkSMmPwD78+i5pjhcz/uQSYQdMQRpLawihddFrbzB0+tE4kIdNbIkZG?=
 =?us-ascii?Q?LEzZ5ZLmAYMYr/tOXXTXlCLq0MKhNu0hGlu+hM8iLBtnotXfejgPzUG4V1rb?=
 =?us-ascii?Q?GwnwRv2ARw3HTsCuqx5uDEFIO3P2X+wjGGTProQGuhqaq9cWXAie4i5vwwEc?=
 =?us-ascii?Q?gXOIbpZWrJtQ18N4+QsIn3SkV2aoW0KV+oKm7AOMXxkbhb4OdTe1dEGQiZcD?=
 =?us-ascii?Q?B2P8hg6HT4BajrdE4co/XRYzyxJ+bBXPnaP1oxQoqgcup8J1sGM9TuILhTCs?=
 =?us-ascii?Q?MwnuO5Ll86jcnLuY3OGPlna3M+guJFY3lvGZ9NyszVCSJZdq+DLZ4DsAOw5i?=
 =?us-ascii?Q?JA12GPe6X9IGh5GrgAxxAf+IFFcl9qcJjR8Gh+mbFwUbciX02a1KjnrHAbjO?=
 =?us-ascii?Q?0Siyq51enzlnIwgu9Vv/kSUxH1p0HGy8Txvlg+vOTEs0uzeMBBSEAnL3i4Li?=
 =?us-ascii?Q?/cZXlaRxla0q9j3csSTzvJg+JbmbrOw4BSjtjZM63Va763C9sXtBsyPguPt6?=
 =?us-ascii?Q?5BbcNaV2tK/G+meLdcbbIDPjvHbef4WaYCS9Vzj2RCTHug4JvMinhKrP6InR?=
 =?us-ascii?Q?Httrs2ccUwcbKtEi7wRLtSwb8CmihXboY1LqycX1DZZ451tnfK+J1N4m94lv?=
 =?us-ascii?Q?ikQW0n6RekiNrAjRm2PT2T0WKjP0YCuWjMgCnJVvkjO5GTIBdkqV4SNLH3e+?=
 =?us-ascii?Q?sLubBDqptt9XhfvODH30jUrgDDDmxpXPgU1knPd4TjVlwhOV9bEZHv2LBFGG?=
 =?us-ascii?Q?iVASBrKwVw=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: est.tech
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DU0P189MB1994.EURP189.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 053ec53a-98d7-474c-6273-08dee2172aad
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Jul 2026 02:17:06.1227
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d2585e63-66b9-44b6-a76e-4f4b217d97fd
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ccPSwfSMKHcms+jvx+DN4QM4tAgwKjfpOvrFVaY8Q62H9bBbRDgHubHWS4SDWkVgu0GOjrph2hyDE2GhHf1DZ/R4Cs3zBFsWc0A/la8u3JI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8P189MB0886
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.34 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_DKIM_ALLOW(-0.20)[est.tech:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DMARC_NA(0.00)[est.tech];
	TAGGED_FROM(0.00)[bounces-307640-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:koike@igalia.com,m:jmaloy@redhat.com,m:davem@davemloft.net,m:netdev@vger.kernel.org,m:tipc-discussion@lists.sourceforge.net,m:linux-kernel@vger.kernel.org,m:kernel-dev@igalia.com,s:lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[tung.quang.nguyen@est.tech,netdev@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	DKIM_TRACE(0.00)[est.tech:+];
	MISSING_XM_UA(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tung.quang.nguyen@est.tech,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[DU0P189MB1994.EURP189.PROD.OUTLOOK.COM:mid,est.tech:from_mime,est.tech:email,est.tech:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,syzkaller.appspot.com:url,appspotmail.com:email,igalia.com:email,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 1915975A06E

>Subject: [PATCH net] tipc: fix infinite loop in __tipc_nl_compat_dumpit
>
>cmd->dumpit callback can return a negative errno, causing an infinite
>loop due to the while(len) condition. As the loop never terminates,
>genl_mutex is never released, and other tasks waiting on it starve in D st=
ate.
>
>Check dumpit's return value, propagate it and jump to err_out on error.
>
>Reported-by: syzbot+85d0bec020d805014a3a@syzkaller.appspotmail.com
>Closes: https://syzkaller.appspot.com/bug?extid=3D85d0bec020d805014a3a
>Fixes: d0796d1ef63d ("tipc: convert legacy nl bearer dump to nl compat")
>Signed-off-by: Helen Koike <koike@igalia.com>
>---
>
>Tested locally using syzbot reproducer.
>---
> net/tipc/netlink_compat.c | 4 ++++
> 1 file changed, 4 insertions(+)
>
>diff --git a/net/tipc/netlink_compat.c b/net/tipc/netlink_compat.c index
>2a786c56c8c5..d9a4f94ea2d4 100644
>--- a/net/tipc/netlink_compat.c
>+++ b/net/tipc/netlink_compat.c
>@@ -221,6 +221,10 @@ static int __tipc_nl_compat_dumpit(struct
>tipc_nl_compat_cmd_dump *cmd,
> 		int rem;
>
> 		len =3D (*cmd->dumpit)(buf, &cb);
>+		if (len < 0) {
>+			err =3D len;
>+			goto err_out;
>+		}
>
> 		nlmsg_for_each_msg(nlmsg, nlmsg_hdr(buf), len, rem) {
> 			err =3D nlmsg_parse_deprecated(nlmsg, GENL_HDRLEN,
>--
>2.54.0
>
Reviewed-by: Tung Nguyen <tung.quang.nguyen@est.tech>

