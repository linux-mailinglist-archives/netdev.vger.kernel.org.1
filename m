Return-Path: <netdev+bounces-277734-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WBEwG6IL22l48ggAu9opvQ
	(envelope-from <netdev+bounces-277734-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 12 Apr 2026 05:04:02 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id D156F3E2930
	for <lists+netdev@lfdr.de>; Sun, 12 Apr 2026 05:04:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D8945302591E
	for <lists+netdev@lfdr.de>; Sun, 12 Apr 2026 03:03:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09A152D94BA;
	Sun, 12 Apr 2026 03:03:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=verivus.ai header.i=@verivus.ai header.b="K8r7an4p"
X-Original-To: netdev@vger.kernel.org
Received: from SY8PR01CU002.outbound.protection.outlook.com (mail-australiaeastazon11020139.outbound.protection.outlook.com [52.101.150.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78AEF25524C;
	Sun, 12 Apr 2026 03:03:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.150.139
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775962996; cv=fail; b=XiVtF9P/Rlpv3UhZAByMF5PKFD2ZYUeP39Tfc/7v9qTt0PZMLq8xHAouTjDRi0oz0I0Y8dmQEYUtpLDNEaJa1fdqyJ1xgia65I3aoG1YikvZSQPJ5KAs80RTYnVzJju3WA/fk9G/BW2Ngkz1NgVSg4sksfMK7KibqW0tGs+JkmI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775962996; c=relaxed/simple;
	bh=St0QV69XzIlA6L0XwUB1OlhfJFlxNeYVbDjL7KtxmaI=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=blKTjaakdZUzQkk2e7FPwuLjd9bQBy0qNSCwp3y5xERZjqtXhenu4BwA3M1Qdm1Lh5TzHtiRHkCQK/MOdRTg4qoWVRpTVBmIeQK9QuIH3J3FEqmeWzvmKpu3XxF3FvDc6t66Kb24XyvQPyHzLKjmyPiCE3Tk4kU5l8xBHZiVKB4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=verivus.ai; spf=pass smtp.mailfrom=verivus.ai; dkim=fail (2048-bit key) header.d=verivus.ai header.i=@verivus.ai header.b=K8r7an4p reason="signature verification failed"; arc=fail smtp.client-ip=52.101.150.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=verivus.ai
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=verivus.ai
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Qm9/X49MGJrQ7HZ3hDhfkXZy29t4H55EAe4Eood/rdKY0d63l+lLh8/oGj21jwO85u5Q9u6RTZiT3s1kVmNMB3P20ozXAHkpNVqx1JUJ/Twb3aC1lsqCIJGCaXEVaXRVPUxMKovkfVGK5LbO+ktkBNVmC8GnKRUfiBx9EMLn/WA1bJr/VqaMVNJCd6lhU4VvWtw7ocjU2F8NxD4MS2U07pvF+vddEi4HadrivfU2WhdXaVDnv3cJdC8q0ANBJyEsZepkS/mFDyr/8CmP8s3Ca1EyrKusU2DhSLaoHgs7PlFjgLTXROdD6IqX3JO0UJiS3atSy7ds+9WGJq4b99Fh0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lV5AWV7URH8Q6uLLZZOJnYzJTXbze65qgMFVgZSLPTE=;
 b=NGkotd0jylU0O4VpbufllGNmSt6I3+lJ51lpDuVVGAAKDKrh5kj7IEgAkJUsG2YnjmZl4E0CfKxCRrUqoCItJaOEcH8vHkbpTEg0VBad8rcn8JF2Xq5IQSFnZRFgWiT9iKPaO7NY5ybtzjVYnsB1/iy5fS9C8Urxvn63huBykFBhjV/t0+jwI5rslq/5IXNQqHC5UPd/+L5dmn56kWUrfAqI/kLVwRFShnPb7RO7qjZCznkP2h3F2SYzvF8WKSBzLtlbkEgI2vjNVARSv0QCmczkM5cZydBGo4AEPNRUxMbJkgV4OATSVmghA8sc/Pq6vJsXgXw965o2tZvWOeKr8A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=verivus.ai; dmarc=pass action=none header.from=verivus.ai;
 dkim=pass header.d=verivus.ai; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=verivus.ai;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lV5AWV7URH8Q6uLLZZOJnYzJTXbze65qgMFVgZSLPTE=;
 b=K8r7an4pdxtfB3cbWutxSydfMgu9xd6BsD2IUB/l50cHIWjyt/RazPBXhVjvQL/z3J/InpPRIM1ZSExJqKXBjrjuhehOcy7FykZG4Br4KtAgwp9G8UCVKhQNgyNamAryjyhsQiwvM6jGAAeSUdPQ4drLVpKg3p9kE8tM1nQjAnhAGchJcRbhbXSO7QaHUbrYRpimHRGyjqlhp3Z6GsneJorWf+MZiLP4vAKDAD/TRtckrJVMDuwlD1QFrzqmSDIvO4VwjeqN2Dwcbkt478K2e55jSQBfrxiLJJ49wS9YPbSVyyb+Xrn8YFOm/muRdhXsX/+EtEW/tuwxYdJ1reCuBA==
Received: from ME0P300MB0853.AUSP300.PROD.OUTLOOK.COM (2603:10c6:220:22a::5)
 by ME0P300MB0668.AUSP300.PROD.OUTLOOK.COM (2603:10c6:220:22e::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9818.17; Sun, 12 Apr
 2026 03:03:10 +0000
Received: from ME0P300MB0853.AUSP300.PROD.OUTLOOK.COM
 ([fe80::1e3f:9cb9:4a95:b5a2]) by ME0P300MB0853.AUSP300.PROD.OUTLOOK.COM
 ([fe80::1e3f:9cb9:4a95:b5a2%5]) with mapi id 15.20.9818.017; Sun, 12 Apr 2026
 03:03:10 +0000
From: Werner Kasselman <werner@verivus.ai>
To: Martin KaFai Lau <martin.lau@linux.dev>, Alexei Starovoitov
	<ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko
	<andrii@kernel.org>
CC: John Fastabend <john.fastabend@gmail.com>, Lawrence Brakmo
	<brakmo@fb.com>, Eduard Zingerman <eddyz87@gmail.com>, Song Liu
	<song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>, KP Singh
	<kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, Hao Luo
	<haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, "David S . Miller"
	<davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
	<kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman
	<horms@kernel.org>, "bpf@vger.kernel.org" <bpf@vger.kernel.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Werner
 Kasselman <werner@verivus.ai>
Subject: [PATCH v2 1/3] bpf: zero dst_reg on sock_ops field guard failure when
 dst == src
Thread-Topic: [PATCH v2 1/3] bpf: zero dst_reg on sock_ops field guard failure
 when dst == src
Thread-Index: AQHcyijlT5ArfyP5c064P2oaI4incA==
Date: Sun, 12 Apr 2026 03:03:10 +0000
Message-ID: <20260412030306.3469543-2-werner@verivus.com>
References: <20260412030306.3469543-1-werner@verivus.com>
In-Reply-To: <20260412030306.3469543-1-werner@verivus.com>
Accept-Language: en-AU, en-AT, en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-mailer: git-send-email 2.43.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=verivus.ai;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: ME0P300MB0853:EE_|ME0P300MB0668:EE_
x-ms-office365-filtering-correlation-id: 3b45d8cf-3b55-4fae-16cf-08de984007ca
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|366016|7416014|376014|38070700021|22082099003|18002099003|56012099003;
x-microsoft-antispam-message-info:
 fsncDYD2dpAQBgEAFaS0WKKwnnIxw2wHlHZZ6pVRmtzK6Z6Qg6LjiXyJdQPUZh8HjEgqnkYEHwb2k6bllKkCcoFR1EFw7yi/qHtxa9RyA/EPK7+buaZhHN822ZUt62egd8zXFtjqqhks1i3uOO3ejn5jyLI9tbwveL/NXL9kuFjn0aFiQ6wj6SfGuZON4HhC6wI8OI4lkmBvW7Zb/Z/wYq9T4yEzuXCi3V2zGptNL1tewnGdxwMvZVxx9154oIEQDgqZ7TzTClPkUJiarY6QB+n8udhT6aF64Tymv5PCVIh2DPEHEdnjC8AHAltMCdv7MF1jaPHVQKK8R57ybTSfcXwsplOPA148+XBcnfIvMEZxCUhWSTNRYCsTGs8nlyb1FqImvZrRdmzS5zVBNR2d4ick0PVNNKo9/elNyjVkOhFZV3seT3W7ElFBd391Glbk1BqT6Y+kXl33l4CArmIIJqJU8/CY1BsGavrhA1mu2B5ya/Jhbzc3wyJFySRF6WcrR2a7MVRwSrAvuP3TVIjDWJ1dJA3u9i0qAVXGVJoXINt9uRsJ3o6UDuhSpqm5o3XELwWLcdJeOIMHLaOvCfR/5Jrtrb0+AwdxJSZsYNfoA2V+QgTcMry5zH2Pp0C4xSq6xiQnrKpgyYxurpWcoSy0YzmwNTuSwmZ2Oqaixpfs8zc3GOjLeJ3yPfEKrrSlVxFEmhfZJB+EBpK9Krqlk8lcHirmaAWafAtgyEwP+06NmAIMJjxQ4SVgZbsB6SwYJh1DOrgdWEekKm2+LcwWKi4///ekh/ExHb76YWss/43vBsE=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:ME0P300MB0853.AUSP300.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014)(38070700021)(22082099003)(18002099003)(56012099003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?sC+pdh4DDyHEaY6+9cgXzWrp+8YBvbj3vH0IrokZPcJ6Kuqcok0nqZhouH?=
 =?iso-8859-1?Q?MiJNsW5Hzubhx/tSFSs+2pLrjj5O13ZkAXk967gGiWErmU9B7tZvKbLarc?=
 =?iso-8859-1?Q?FoI/SIV5EN94rBYWGph6Eye3tt4ZvLh9WmcB0Txg1n5o8qBdOUJN0lO5ES?=
 =?iso-8859-1?Q?8vYgltM54UniB3LjbBHHk+5tHSwPSimhfN086lSEjmGE9tXsBzzcY+7asA?=
 =?iso-8859-1?Q?Ojx/CEQ76NzxhMkYFMm03ZQG6BIOcqaeawf3OuDiQKXSLmOxmGqIjOBz+V?=
 =?iso-8859-1?Q?o15KvSjEh8Voyjp+8QtazmYj+hdnQ6ibMIKAKQuKwu9AJP1INw+a4IrI/e?=
 =?iso-8859-1?Q?Tu+l4wJSSOXN96idkT7bqYjNWeDcPw/YbB1Orw09192oK0cJFjwdyEXjBW?=
 =?iso-8859-1?Q?spA1pLCZ9BEcbef9W03y76u9qg3cgSdR2RXi3Pl1ahXPT03VlQBJvxKA4+?=
 =?iso-8859-1?Q?fgeqC0O+2f1Nj2akwjj4gUoY//Lxl4Cah4nryjws8VmTxS+gCsIbcD7tZO?=
 =?iso-8859-1?Q?wR8S7sI6i8JGYAkHgpPtth13WHxj5iY8T+StGxJ7ark5TGgclS6L8l9v60?=
 =?iso-8859-1?Q?tuhyYefVM+e9BOTKBfjOjhS7VmD7mFxK7n3C2QveBp+xvDopPFIya8izL2?=
 =?iso-8859-1?Q?5nh4tfhYr8G1rMnCUUry6gXpRypoDqtH2jC79a96ndI50TeWloB7SrkLG6?=
 =?iso-8859-1?Q?dHi3+Tu7/SJiRupv1xFUkm8jwOzWvB9ulAZp2YEsLcS/p1MqdwUCXRdNyb?=
 =?iso-8859-1?Q?25E5ZIMJMztAn4PElZhA4BQ/Qfuvkbfk4o3i8xVnfm7S1ZH9zHiFowaKyK?=
 =?iso-8859-1?Q?wq0YjxFrVVCQYtQZQifwQIkybrIBZ4G684AvhLZCAiMcANzvBhTSvV5m1b?=
 =?iso-8859-1?Q?1fqLlw0YrS9BZHHlWxkMpk8wZkzwF4pqL6e7iHk0IX7PUaeY9rNLbiMIxj?=
 =?iso-8859-1?Q?2UIyocLBSoJIe5+6RcLaskHZFG8HRaEmQtgNjUWgHsc9yE6BnMTrSxAhE8?=
 =?iso-8859-1?Q?Rx85UDNM4hSB/IVHRMcfZlbrIGAhJhYkPK2ajqxSOZODBuhzRs90Y/yt1K?=
 =?iso-8859-1?Q?xBU5ngQrRWXZi2vZQkL0NrZHXFxSIZbfcEDLTsj0w2EvxonsgDVzFjfapY?=
 =?iso-8859-1?Q?VPusqhxR6lnu4Uk7roru4BsrRtVpRIEgo/CiIA1ods+hF8MhYyvlB6qwF4?=
 =?iso-8859-1?Q?jDLAqvOxjk9bFDAkCJ8+V9YYPfu08wCAvBLth6/hbmHqYLucpe8FGtMlB2?=
 =?iso-8859-1?Q?lMzry9BcDrbmtBrpLwIRtn7f4JUdtBNM3TL5LpzrualI8wGvzHIfH052w2?=
 =?iso-8859-1?Q?WW6pM3s55BlOYgPKJSL3sbVlJpQj8U8bSCngVP+jO0xJVUxEkJ7IbMlGPi?=
 =?iso-8859-1?Q?ONBRJeS8SaoKWmkzNvh5Q/uFR9EgU6eEkOmb9DC8vWBbBokWzpw5erXiwG?=
 =?iso-8859-1?Q?eHOKX9HMsE3ui2lRTVM2VtEtAS9aVPgj/EigcIqu6kLoxZ/3/cTnhi/Tjw?=
 =?iso-8859-1?Q?l82uZ6mOSH+cJrRqlkStmzNh0ZNLNm7ekgRlrCvzx3A6ekIbGij4QE2qQH?=
 =?iso-8859-1?Q?zyhyeJdUJsin+KKe7Vf84CTxkVZTlb1CHuTYUK0l87SnxsWq9h12lt2km2?=
 =?iso-8859-1?Q?ShFgHHbNYh4dSjYFfNzHRZsFLSG/x6uNBOqLzh/TDR+h0XB6F02IlKqXYY?=
 =?iso-8859-1?Q?BrDrxttOsBrY77fFvdJLSe2MkBZ3WNv8bgQTd8L3fMDRONXUcXwHlHDviR?=
 =?iso-8859-1?Q?C5y2jAz6ITnI9s24TBHygIBOh7O+tsJvqTOKFALySyZGDO6hAQyw3d0WqT?=
 =?iso-8859-1?Q?/4jPYV/vYQ=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: verivus.ai
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: ME0P300MB0853.AUSP300.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 3b45d8cf-3b55-4fae-16cf-08de984007ca
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Apr 2026 03:03:10.8658
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: ccdcedb0-4edc-4cc8-9791-c44ee6610030
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 7evh+um3CLT1raX9ErPfcEw8cjFesQd5nWMA3pm+LHa5f7Q6hSG1ja9aoGtbrnobknlmNw0e5ztQLOFGja4F1Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: ME0P300MB0668
X-Spamd-Result: default: False [3.14 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	R_DKIM_REJECT(1.00)[verivus.ai:s=selector1];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[verivus.ai : SPF not aligned (relaxed),none];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-277734-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[22];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[gmail.com,fb.com,kernel.org,linux.dev,fomichev.me,google.com,davemloft.net,redhat.com,vger.kernel.org,verivus.ai];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[werner@verivus.ai,netdev@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[verivus.ai:-];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-0.964];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,verivus.com:email,verivus.com:mid]
X-Rspamd-Queue-Id: D156F3E2930
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

When a BPF_PROG_TYPE_SOCK_OPS program reads a tcp_sock-backed context=0A=
field (e.g. ctx->snd_ssthresh) or ctx->sk using the same register for=0A=
source and destination, SOCK_OPS_GET_FIELD() and SOCK_OPS_GET_SK()=0A=
load is_locked_tcp_sock/is_fullsock into a scratch register rather=0A=
than into dst_reg. On the guard-failure branch the macro only=0A=
restores the scratch register before falling through, leaving=0A=
dst_reg holding the unchanged context pointer.=0A=
=0A=
Callers expect dst_reg to read as a scalar 0 when the guard fails.=0A=
Instead the BPF program sees a kernel heap address, which the=0A=
verifier has already typed as a scalar, giving a narrow kernel=0A=
pointer leak. Clang does not emit the dst =3D=3D src pattern for normal=0A=
C ctx field reads, but it is reachable via inline asm and=0A=
hand-written BPF.=0A=
=0A=
Add an explicit BPF_MOV64_IMM(dst_reg, 0) on the failure path in=0A=
both macros and bump the success-path BPF_JMP_A() to skip over it.=0A=
=0A=
Found via AST-based call-graph analysis using sqry.=0A=
=0A=
Fixes: fd09af010788 ("bpf: sock_ops ctx access may stomp registers in corne=
r case")=0A=
Fixes: 84f44df664e9 ("bpf: sock_ops sk access may stomp registers when dst_=
reg =3D src_reg")=0A=
Cc: stable@vger.kernel.org=0A=
Signed-off-by: Werner Kasselman <werner@verivus.com>=0A=
---=0A=
 net/core/filter.c | 6 ++++--=0A=
 1 file changed, 4 insertions(+), 2 deletions(-)=0A=
=0A=
diff --git a/net/core/filter.c b/net/core/filter.c=0A=
index 78b548158fb0..53ce06ed4a88 100644=0A=
--- a/net/core/filter.c=0A=
+++ b/net/core/filter.c=0A=
@@ -10581,10 +10581,11 @@ static u32 sock_ops_convert_ctx_access(enum bpf_a=
ccess_type type,=0A=
 				      si->dst_reg, si->dst_reg,		      \=0A=
 				      offsetof(OBJ, OBJ_FIELD));	      \=0A=
 		if (si->dst_reg =3D=3D si->src_reg)	{			      \=0A=
-			*insn++ =3D BPF_JMP_A(1);				      \=0A=
+			*insn++ =3D BPF_JMP_A(2);				      \=0A=
 			*insn++ =3D BPF_LDX_MEM(BPF_DW, reg, si->src_reg,	      \=0A=
 				      offsetof(struct bpf_sock_ops_kern,      \=0A=
 				      temp));				      \=0A=
+			*insn++ =3D BPF_MOV64_IMM(si->dst_reg, 0);	      \=0A=
 		}							      \=0A=
 	} while (0)=0A=
 =0A=
@@ -10618,10 +10619,11 @@ static u32 sock_ops_convert_ctx_access(enum bpf_a=
ccess_type type,=0A=
 				      si->dst_reg, si->src_reg,		      \=0A=
 				      offsetof(struct bpf_sock_ops_kern, sk));\=0A=
 		if (si->dst_reg =3D=3D si->src_reg)	{			      \=0A=
-			*insn++ =3D BPF_JMP_A(1);				      \=0A=
+			*insn++ =3D BPF_JMP_A(2);				      \=0A=
 			*insn++ =3D BPF_LDX_MEM(BPF_DW, reg, si->src_reg,	      \=0A=
 				      offsetof(struct bpf_sock_ops_kern,      \=0A=
 				      temp));				      \=0A=
+			*insn++ =3D BPF_MOV64_IMM(si->dst_reg, 0);	      \=0A=
 		}							      \=0A=
 	} while (0)=0A=
 =0A=
-- =0A=
2.43.0=0A=
=0A=

