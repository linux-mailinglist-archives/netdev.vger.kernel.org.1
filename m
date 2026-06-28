Return-Path: <netdev+bounces-302404-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id wEAkHwdQQWoBngkAu9opvQ
	(envelope-from <netdev+bounces-302404-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 28 Jun 2026 18:47:03 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id A8FD76D46BC
	for <lists+netdev@lfdr.de>; Sun, 28 Jun 2026 18:47:02 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=simnet.is header.s=sel1 header.b=fyFfpirI;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-302404-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-302404-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=simnet.is;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CA7DF300CE61
	for <lists+netdev@lfdr.de>; Sun, 28 Jun 2026 16:46:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E56B7288530;
	Sun, 28 Jun 2026 16:46:50 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp-out2-04.simnet.is (mx-biz-04.simnet.is [194.105.232.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD7AC258CE7
	for <netdev@vger.kernel.org>; Sun, 28 Jun 2026 16:46:47 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782665210; cv=none; b=H9ibwU+tBrNQM/W1Qsj5bGMkjIwrjRyDTh67iZP3WCBDckeGFelTgXtlREyBmz0yCEn7zo43U4An6u0SyHwFTdUdZBP6pqwh1Y9llHGlzPMj5VvtMJarkcn2Vurmyt1ATAt8W78HzUkimmQezjzeMl8mnOYixw9CThQlshYlLV8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782665210; c=relaxed/simple;
	bh=Uv7rd1aiPXpjgtLzpP7EOH6SJ3EhXaxlArIDWW1Ko/w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UkW9WLObgt0H+qTjHlCkR1jOWQx06CKH3aWkqGRsaoIipP2BCsvdCY6iYLBgxB0YMOsqo4s4a+d/7688as06xma3csckqyc7J5E39QPjALN6TSyNqpZ1S6g8nOqkvwZL7m0SJK7AQDprjGFBqTN6/G0HQcyDPBnWoGN7QV3KUDY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=simnet.is; spf=pass smtp.mailfrom=simnet.is; dkim=pass (2048-bit key) header.d=simnet.is header.i=@simnet.is header.b=fyFfpirI; arc=none smtp.client-ip=194.105.232.15
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=simnet.is; i=@simnet.is; q=dns/txt; s=sel1;
  t=1782665208; x=1814201208;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=+pmPmHsJTHfHYiAcza7jGqlHqxUYpte4tVzeN4MLt1Q=;
  b=fyFfpirIDaAL+0zSuhhZj1xMcZVONj3NR0aKwcMC6rESBMhP+iNpIMkq
   2/RuCePVQQYAbKv5KUE3o3oLeVbuqNQDyircsVh6hV993Js/KxqrjDSNO
   U8ZgxFKpaFXHMAvAdvaF4vDZkeZjHzGb6smTxxhinTQkPbPUPIcBL14I8
   YsAOIRoqGDPrWHEjPn3Ildd2XxeUFJ0Iy8E1yciemzAHb8NVHJF8sMKrm
   wc7gGcJn8+OYHf1PMOUHG0KYWLIonDJ4oI+vD+OMbp7WcQnK5zA4Qx3A6
   Gpun/s3yV1zDcY+x3lQfEHh2kLOprkU90Mm0hLPf9GRIwDun0gYtmA8J+
   A==;
X-CSE-ConnectionGUID: rfzw2CTAT3S0o1sOdAiKyw==
X-CSE-MsgGUID: 5KMmInJITtCxGDENcKIJbg==
X-SBRS: 1.9
X-ThreatScanner-Verdict: Negative
X-IPAS-Result: =?us-ascii?q?A2GLAgAeTUFqd9Niq09ahRq5XA8BAQEPUQQBAYUGAo1MK?=
 =?us-ascii?q?DgTAQIEAwIDAQEBAQEBAQEBAQELAQEGAQEBAQEBBgYBAhABQw47hglTgmIBh?=
 =?us-ascii?q?AAGOj8QC0YQRgaGCbgWgTSBAd5DgXKBTYVxgmoBhXaEfDwGgg2BSoJ2PosIB?=
 =?us-ascii?q?IMugXiPGlJ4HANZLAFVExcLBwWBI0MDgQYjSwUtHYEjIR0XFh5YGwcFEiAqQ?=
 =?us-ascii?q?UUjAydZPzgLQwWBWQKCDE4jHwM5f4Ewf2RmFTA1gQIBER4KbEIkJwMLbT03F?=
 =?us-ascii?q?BuSDsldhCehdTODcQGTYQyTDZkIqUKBf4F/LAcaCDCDI1IZD9xngTYCBwIHD?=
 =?us-ascii?q?gMLkhyBSwEB?=
IronPort-PHdr: A9a23:2IsQExEqTGd4UWQ2AIvhwJ1Gf3FKhN3EVzX9CrIZgr5DOp6u447ld
 BSGo6k20RmRBc6Btq0c1KKW6/mmBTdcp87Z8TgrS99laVwssY0uhQsuAcqIWwXQDcXBSGgXO
 voHf3Jeu0+BDE5OBczlbEfTqHDhpRQbGxH4KBYnbr+tQt2agMu4zf299IPOaAtUmjW9falyL
 BKrpgnNq8Uam4RvJ6gxxxfTvndEZ+tayX1oKF+Rgxrx5Nq78Jp//yhNof4s+MBNXKrgc6gkU
 bBUCSktPnwo6sHsqRTMQgyD62cGXG4LiBRIGQ/F7B/7Xpf1rCT3s/d21TeZM8PrU706QCyu4
 ahzRhDnkSsKKTE3/nzPhsN/kKxUrhShpwdiw4HPe4GaKOB+fqLGctwEQ2dKQ9tcWDZAAoO4a
 IsPEvYBMONFpITzu1cCsR2zDhS3Cejx1jFHmGP53awi0+QgDw7G2hAgH8kTu3jQtdn5KbseX
 fywwKTO0D7Nbe5Z2S3l5YbGch4vv++BU69zf8rfxkYgCx7KgVeLpIz5Iz+SzPgBv3SH4+Z+U
 ++klm4pqxt2ojiq3sohl4vJiZgPylDC9CVy3YU7Jdu3SE56fNWqEZpQtzqeN4RsWcMiRGdos
 zs9x7Idu560ZjIKyJImxx7eZPyKaJOI4hPmVOaXPzh4mGhpeLOkhxur90Wr1+LzWNWu3llQs
 ipFjsfDtmoL1xHL5MaKSuZx80eh1DuPyw3f9PxIL0ApmafUK5Ms3KM8m5QXvEnAECL7mkb7g
 qGVe0gg9eal9uTqb6v4q5OBOIF5hQfzObktlMynGek1MAwDU3KG9em+ybHv50n0TbZQgvEoj
 6XVrYjWKMcbq6KjHQNZzJov5wyxAjqoytgUgHgKIVxDdRmalYbmIUvOL+r9DfqnhlSslypky
 O7eM736B5XNMmDDkLD8fbZh80JcyBQ8zdRY559MFLEBIenzWlPouN3ZDx85NhS0w/zgCNRy1
 oISQH6DD6CDPKPMsF+I/f4vL/ONZI8OoDr9Kv4l6ODyjXIhm1IQebOl0YYVZXylBPhrJ0aUb
 WDyjtscDGsGpg8+Q/briF2GXz5TfXGyX6ck6z4gCoKpF53DRoasgLyA0ye2BYZWZmFDClCKD
 3joa5+IW/YXaC6KOM9ujiQEVaS9S48mzRyurxP6xKR/LurU5CIYs4nu1N5r6O3PmxAy8iZ0D
 8eF02GJUmF0m3gHSCEs3Kxlpkx90FiD3bBig/NEDdxT++9JUgAiOJ7a0eN6F839VRzfftqSV
 lamTcupASsrQtIy3dAOeUB9FMumjhzZ2CqqGbAVm6SNBJMv6q3cxWT+J95hy3ba06ksl0cqT
 tNANWK4ga5x9BLdCpbKnUuEj6qqb7oT3DDO+mmZ1WeOokBYUBVsUancXHEfZ07Wrczj5kPFQ
 L6vCa0rPhdOxMKYNKtKa8bpjUlcSPfiI9TSe3++m2SxBRaN3r6CdIXkdGsD0ivBFEUKlRgf8
 muDNQckHCeuv3rTAiR3G1z3bE3g6fJ+qGu1TkIs1w+EdlVv2bXmsiIS0MeARusT07RMmCokr
 jRyE1unl4bNF9eYpwdnVKNRfcw6+lRf0X/cvQFneJu6IPYxqEQZdlFdvUr00RQ/K4NPkIAFr
 WguxRF1L+rM2lFIbTWZ3J/YIbzSLGTuuhG0Pf2FkmrC2cqbr/9coM8zrE/u6UTwThJKGxRPy
 NxJyz6b+4mPVFZUSpP0VEsrsRlh9PnWYSg4soXT03Akcay5qSTL1N9hAuw5gg2hcNFSPOLMF
 AL7H8AAQcn7LussljCU
IronPort-Data: A9a23:AUrHS6IpViruUI0OFE+RZJQlxSXFcZb7ZxGr2PjKsXjdYENSgTAAz
 2cZWWvQPP6IYGP1eN0gYNu+pElUu8fTn4RhGlEd+CA2RRqmi+KcXo3BcR2Y0wB+jyHnZBg6h
 ynLQoSYdKjYdleF+FH1dOSn9SAivU2xbuKUIPbePSxsThNTRi4kiBZy88Y0mYcAbeKRWmthg
 vus5ZeDULOZ82QsaDxMtfjT8EoHUMna4Vv0gHRvO5ing3eG/5UlJMp3Db28KXL+Xr5VEoaSL
 87fzKu093/u5BwkDNWoiN7TKiXmlZaLYGBiIlIPM0STqkAqSh4ai87XB9JAAatjsAhlqvgqo
 Dl7WTNcfi9yVkHEsLx1vxC1iEiSN4UekFPMCSDXXcB+UyQq2pYjqhljJBheAGEWxgp4KXtA5
 +NCAwwkUku43+Xv25W3Y+hPl9t2eaEHPKtH0p1h5S/YFupjU5HGW7/N9c4dhGt2mMFVAbDff
 KL1axIwPVKZPEQJawdRUstn9AurriCXnzlwolCcv6w24mf71w101rXxdtvOEjCPbZwOxR7E+
 TiYpwwVBDlHF/ma6Dyn006wrf/gsQ7dU6EzNre3o6sCbFq7nDdNVExJDDNXu8KRkVKzQ9JSL
 WQS9zYxqrIx7Ei2S9PwRVu/unHslhgRR9ZdDcUk5wyXjKnZ+QCUAi4DVDEpVTA9nNE3XiBvx
 F6Mh8nuFS0q6OHTV3OG6vGVtlteJBT5M0cYaz0bFyA5yuW4m9k01wnoQv9iM7+q24id9S7L/
 9yckMQpr5Qo5fPnOo2l/EvbxiCto4DTSR4ko12LGHyk9R8/ZZXNi22UBbrzsKkowGWxFADpU
 J04dy+2tr1mMH11vHbRKNjh5Znwjxp/DNEjvbKfN8N6qWj8pCfLkXF4+zx4P04hP8YKEQLUj
 LvokVoJvvd7ZSL2BZKblqroWqzGO4C5RIy9Dpg5r7NmPvBMSeNw1Hw3PRPAhzu3zCDBU8gXY
 P+mTCplNl5CYYwP8dZ8b751PWMDrszm+V7ueA==
IronPort-HdrOrdr: A9a23:fz11cq9EF8sMC0pSwk1uk+DTI+orL9Y04lQ7vn2ZhyY1TiW9rb
 HIoB17726RtN9/Yh0dcLy7V5VoBEmsk6KdgrNhWItKPjOW21dARbsKheCJrgEIWReOlNK1vp
 0BT0ERMrPNMWQ=
X-Talos-CUID: 9a23:d4WPOm4N7u+1ydmUSNss7kAGBZoOTlThl0yIJBajLmpASZ6EVgrF
X-Talos-MUID: 9a23:PpemIwTINd1kWp+bRXSxpxRnFcFKwpiyI1AivbggsOqlFyZ/bmI=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.24,230,1774310400"; 
   d="scan'208";a="133047260"
Received: from vist-zimproxy-04.vist.is ([79.171.98.211])
  by smtp-out-04.simnet.is with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jun 2026 16:45:36 +0000
Received: from localhost (localhost [127.0.0.1])
	by vist-zimproxy-04.vist.is (Postfix) with ESMTP id D17EB609931C;
	Sun, 28 Jun 2026 16:45:35 +0000 (UTC)
Received: from vist-zimproxy-04.vist.is ([127.0.0.1])
 by localhost (vist-zimproxy-04.vist.is [127.0.0.1]) (amavis, port 10026)
 with ESMTP id qB-4fsV4piSI; Sun, 28 Jun 2026 16:45:35 +0000 (UTC)
Received: from kassi.invalid.is (85-220-33-163.dsl.dynamic.simnet.is [85.220.33.163])
	by vist-zimproxy-04.vist.is (Postfix) with ESMTPSA id A1FE4609931B;
	Sun, 28 Jun 2026 16:45:33 +0000 (UTC)
Date: Sun, 28 Jun 2026 16:45:21 +0000
From: Bjarni Ingi Gislason <bjarniig@simnet.is>
To: Stephen Hemminger <stephen@networkplumber.org>
Cc: netdev@vger.kernel.org
Subject: Re: iproute2: trailing whitespace in man pages
Message-ID: <akFPoSsjKRmPpgBD@kassi.invalid.is>
References: <178243847243.6540.10252433987238870483.reportbug@kassi.invalid.is>
 <20260626081534.70b9f2ff@phoenix.local>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260626081534.70b9f2ff@phoenix.local>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[simnet.is,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	R_DKIM_ALLOW(-0.20)[simnet.is:s=sel1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	TAGGED_FROM(0.00)[bounces-302404-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:stephen@networkplumber.org,m:netdev@vger.kernel.org,s:lists@lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp,simnet.is:dkim,simnet.is:from_mime];
	FORGED_SENDER(0.00)[bjarniig@simnet.is,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWO(0.00)[2];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[simnet.is:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bjarniig@simnet.is,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: A8FD76D46BC

grep -n -e ' $' -e '\\~$' -e ' \\f.$' -e ' \\"' -e ' "$' <file>
 
Added option -e ' "$' for the last argument of macros.

