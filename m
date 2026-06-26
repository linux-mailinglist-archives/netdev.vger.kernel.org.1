Return-Path: <netdev+bounces-302081-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id U0xHBRDdPWoN7QgAu9opvQ
	(envelope-from <netdev+bounces-302081-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 26 Jun 2026 03:59:44 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 93D616C9A1F
	for <lists+netdev@lfdr.de>; Fri, 26 Jun 2026 03:59:42 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=simnet.is header.s=sel1 header.b=YRVHhxdX;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-302081-lists+netdev=lfdr.de@vger.kernel.org" designates 104.64.211.4 as permitted sender) smtp.mailfrom="netdev+bounces-302081-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=simnet.is;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 42D2130261BE
	for <lists+netdev@lfdr.de>; Fri, 26 Jun 2026 01:56:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E419629D294;
	Fri, 26 Jun 2026 01:56:23 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp-out2-06.simnet.is (smtp-out2-06.simnet.is [194.105.231.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E3CB288C2D
	for <netdev@vger.kernel.org>; Fri, 26 Jun 2026 01:56:17 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782438983; cv=none; b=q9PrrxfYDbpAET0bAajjAg1NiVGy2DcVhs44hhKeEXdtX/rho3j7FK1HyPgTcJl1/Z+H+tgsjj2kQ84PTrcLqHhpRKBXpknK1tAJc/L+sx/4ACcV42cX3uQNXktkosqvLmiKxaKYmK60Qh4n4eY4BS9NoMGEguSebdWRGrhlQis=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782438983; c=relaxed/simple;
	bh=RieowJ4mb0J8ZmOxkrhxVYvQK9T5+B3M7TZPnh6/U6A=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=TQbWWrLSdrc59b3So32+hXTCQdMJX6cbHaMOWzptP27TRgkpJY93EZISx0XfhT0cPtCxVLe3BtUMx9WyaH/eWqbzPK0hC6BIb2Ha+emoKiVzkpcTfqbRu31zYB1gM3yRbrKIRJfLdjCM8+0SA1aAr6NoQmCfzO7mcRR0MUqS8o8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=simnet.is; spf=pass smtp.mailfrom=simnet.is; dkim=pass (2048-bit key) header.d=simnet.is header.i=@simnet.is header.b=YRVHhxdX; arc=none smtp.client-ip=194.105.231.14
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=simnet.is; i=@simnet.is; q=dns/txt; s=sel1;
  t=1782438978; x=1813974978;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=L6xu+ViI1beJhLXu3iA4gFUNi+Sr1euxHuzabeUmcvc=;
  b=YRVHhxdX5jVK/e2rBUEZQSEjHxkNlFNgAxCfccMtDbzVTroICMS4Q1UE
   EX5D7/D4iDDO3gsnjd+5EDxLGxp5Okm3OQvFYNwUsmQD+c00PTOzuAZkG
   2xwAymveNJiGs+25IJolC4MGlsbF1oRGm9Gb7bj826IBfCn1mWLjPv61n
   lcAH/sp7dkmnMLk2jB1De1iaNZ477Y5+pfT+7q1MggEirP3Or28Hhl05v
   clq66c+f7vUK9v6fuuF3HrbHfkmM//BqEQTziz05yOhyqcdB1A6tZqCL6
   0Mi0s+1WrT4Ksp/cxoV1GNvXn7zULT87JVou49+9SDho6Zmgwfu1/Z430
   g==;
X-CSE-ConnectionGUID: LY7Rzx5gSWWHnUvwYncG5A==
X-CSE-MsgGUID: atxgtTwRTYuCj2OTmEvgKg==
X-SBRS: 1.9
X-ThreatScanner-Verdict: Negative
X-IPAS-Result: =?us-ascii?q?A2HXAQDd1z1qd9Riq09aHAEBAQEBAQcBARIBAQQEAQGCE?=
 =?us-ascii?q?IJBgnQDlkmeMoFqCAcBAQEPUQQBAYUGjU4oOBMBAgQDAgMBAQEBAQEBAQEBA?=
 =?us-ascii?q?QsBAQYBAQEBAQEGBgECEAFDDjuGCVOCW4QoAV4tfCeCTzSCc7hggTSBAd5Dg?=
 =?us-ascii?q?WASFAGBOIVxgmoBhXaFOAaCDYFHA4M0hAkYAQEGhl8Egg0VehIbgV2PKUiBH?=
 =?us-ascii?q?gNZLAFVEw0KCwcFgWYDNRIqFW4yHYEjPhc0WBsHBYEdgW6BAoUAIx8DOX+BQ?=
 =?us-ascii?q?IEkZGYVMDWBAQERHgqBRgwJAwsYDUgRLDcUG0JuB4xyFw+BQQkBAnABJgMHL?=
 =?us-ascii?q?y4BewgEPAM2LSETk2ORMYxUk1mBPoQnhmCbFTMig2KTTww8klGZCKQjN4Rog?=
 =?us-ascii?q?X+BfywHGggwgyJTGQ+OByEFFtB2eRAtAgcCBw4DC5FoBy2BSwEB?=
IronPort-PHdr: A9a23:sKUnIRCBjKjElWDrEQMJUyQU6EQY04WdBeb1wqQuh78GSKm/5ZOqZ
 BWZua4wygeRFt+Huq8fw6qO6ua8AjBGuc7A+Fk5M7VyFDY9wf0MmAIhBMPXQWbaF9XNKwEcI
 oFpeWQhwUuGN1NIEt31fVzYry76xzcTHhLiKVg9fbytScbdgMutyu+95YDYbRlWizqhe7NyK
 wi9oRnMusUMjoZvJKY8xgHVrndUdOha22xlKFaTkhvy+8y8+IJv/zlKt/8u+cNNXr/2c7gkQ
 bBdET8rL3076Mr3uBbMSgeC+mESWXgMnBpSBAjF4hD6XpPvvSb/q+FwxiqUM9DoQL4tQTis4
 L9lRxDxhCoZODA37XnbhcNsgq1VphKhvAF/zJXPYI6JLvp+f7jScs0cSGFcQ8teTS1BAoe7b
 4sSE+oMOPtToofhq1cSqxa1GA+hD/7txDBVnH/7xaM03eQ/HwzYwQIuHN0Bv2jJo9vyL6oSV
 Py5wbPSwDjZc/9axzHw45XIfBA7pvGMWKp9fNfTyUY1DQPFiFSQopHmMTOT2eQNsnWQ4ethV
 eK0j24osRpxoj+pxswxjYTGnYAVxUre9SV/wYY1JNK4RVVgYd6lFZtQsT+VN5dsTsMjWGFlo
 SA3waAJtpCnZiYF0ognxwLBZPyddYiF+hztWumTLDl3gH9pZbKxiwqu/UWvyuDxV8a63VVUo
 idEndTBuH4A2gDd58aHV/Zx40ev1CiM2g3d6+xJIVw4mK7dJpU8wbAwjoIevEbHEyPshUn7j
 rKael8g9+Wr8ejrfKjqqoGEO4J3igzyKLoiltKjDegiPAUDUXKX9fm92bDt+0DyXa9Egecsk
 qbDtZDXPcEbpqmkDABLyosj8BO/Dyu+0NQfgHkHMEpJeBKZgIjtPFHDOO74Dfakg1SwiTtqx
 vHGPrj5ApXXKXjCn7fgca9h50Nc0gYz09Ff54lICr0bIfLzQVf9tN3eDhAnLwy52+TqBdFn2
 o8DW2+DH7WVPafRvFOS+O4jPveAaJcQuDnnKvgl4/DujWU+mV8YZaSmxpkXZ2qiHvRgIkWZY
 HXsj8waEWcLuwo+SvLliEGYXT5SfHa+R7g86S0jCIK6EYfDQZiggKec3CigG51WZ3xGB0uXH
 nf1eIWEQO0AZz+MLcB6kzwLT76hR5Um1RG0uw/206BnIfbM+i0EqZLj08B45+vNmhEu6DN7E
 dqd3nqTT2F7gGwIXSU63KNhrkxnzFeMz6x4j+ZfFdxJ6PNFSgE6OoXEwOxgF9/yQh7BfsuOS
 Fu+XNmqGT4xQcw2w9ENeUhwA9asgA3b0yqwHbAVib+FCoYs/6LC3njxPNp9x2/H1akgilkmW
 tFPNWqph69/7gTfG47En1+Hl6arbqQcwDTB9GaYzWaWoU5YUw9wUaDdUH4HaUXZo8r36F/eQ
 rGoEbgoLw5BxtSYKqRWctDnlUxISu/sNtjGeGKxg2mwCA6QyL2VdITkdDZV4CKIDkUYnw0N1
 WiJOBJ4BSq7pW/aSjt0GgHBeUTppMN8oWm9TwcVyQ6LJ2JgzL684RkTzaiWSfoJ2LMFtw86q
 jByEUr73smAWInInBZoYKgJOYB121xAz2+M72SVX7S7Krx6w1kDb0Ev4QX11hBxB5kGkNN55
 H8pzQ8nL6We3RsBcj6Dxpn/N/XRLXW65xGgbaPamxne3d+a971J6aE+rFPu1Dw=
IronPort-Data: A9a23:PjmLu65RKu/+2xM0y/tTuQxRtB/HchMFZxGqfqrLsTDasI4TYxWz/
 BJIDDfTeK7WfDCwLJpG3L7Go05Vup6Hz9MySAVv/H02RntHpZHLXdnBcEuqYS/MIpTORRg95
 s8SOteafZ9sEXXSrE70aOS8/HAt3v3TGretBIYoVswJqSpMEU/N3jo5wbJp6mIRveWEPu+th
 T/Ti5LRYAD0hDQuPj4fsvuK8kk27aWp6W1E5lc1aKsQ4FPXvnREV5h3yYOZdiChGtYOdgKZq
 0cv6Jnjows1Kj9wUovNfo7TKxNMGviOe1DX1BK6YoD66jBavCs+z60nA/QVbEZTml2hkst4o
 Dl3ncXYpTwBYOuWxIzxbzECS3sgZfMcpeedSZSCmZX7I3PuIiWEL8pGVCnaDaVAks5rDGdH8
 +AvKTxlRnirm+KszbunffJnj8IlIdODFNt3VqZIlGyx4V4OGPgvco2SjTNq9G5YavNmQZ4yU
 /EkhQ9HN3wsVfHg1mA/U/rSlM/w7pX2nqYxRFi9/cLb6ECLpOB9PSSE3HM4tbVmSO0M9nt0q
 F4q8EzdM04gJszCxgG6zVKqu/HQrCXwd987QejQGv5C2DV/x0QNCQYKEEm6pOGjjV6vHooCb
 VIV4TZorLNaGE6DEYi7BkLh5i/U+ERFAbK8EMVjgO2J4qDW6hyfB2kLZiVAbdorqIk3XlTG0
 3fQxYK2W20x6+D9pXS1/6uEoi+OJhIpHHIpZ3UjcQ4o/dbAr9Rm5v7IZow4TvLk0YSd9SvL6
 yuXpi0/m50ZkMEQkam291HOhXSrvJehZgg4+gnaQEq74Q5jIo2ofYql7R7c9/koEWqCZkeAp
 2RBicmb9PoJHYDIzHHLXuQWAPeo/J5pLQEwn3ZLLsYb5STw9EWcQqBW3S9hFUFiHZstLGqBj
 FDohe9H2HNEFFqRBZKbjqqvCt82iLrhEMz/UeDFK4ITJIZwbxPB/ToGia+sM4LFzRVEfUIXY
 83znSOQ4ZAyUvwPIN2eHbh17FPT7npirV4/vLiip/hd7VZhWJJlYe1ebgffMblRAFKsuwjT6
 N8XOsuEoyhivBnFSnCPq+Y7dAlWRUXX8Liv+qS7gMbac1I+QAnMypb5ndscRmCSt/4Ky7mRp
 inlAR4wJZiWrSSvFDhmo0tLMNvHNauTZ1piVcDwFT5EA0QeXLs=
IronPort-HdrOrdr: A9a23:MGi9l6M9hnU2mMBcTtSjsMiBIKoaSvp037Dk7SFMoDhuA6ilfq
 GV7ZEmPHDP5Ar5NEtOpTniAtjjfZq/z+8X3WB5B97LN2OKhILCFuFfBOXZrQEIYxeOkdJg6Q
 ==
X-Talos-CUID: 9a23:Raw2ZWAHcSJHB5j6Ew1Wq3QGCp0qSULi7HHtPVCJD21GFZTAHA==
X-Talos-MUID: 9a23:qcl8xwZJeVJi1eBTviP8iy1eK/1U0rmFChoqrZArpcanOnkl
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.24,225,1774310400"; 
   d="bugs'?scan'208";a="129769635"
Received: from vist-zimproxy-05.vist.is ([79.171.98.212])
  by smtp-out-06.simnet.is with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jun 2026 01:55:05 +0000
Received: from localhost (localhost [127.0.0.1])
	by vist-zimproxy-05.vist.is (Postfix) with ESMTP id 7139720FF7FF;
	Fri, 26 Jun 2026 01:55:05 +0000 (UTC)
Received: from vist-zimproxy-05.vist.is ([127.0.0.1])
 by localhost (vist-zimproxy-05.vist.is [127.0.0.1]) (amavis, port 10026)
 with ESMTP id efcsRRSH3k7B; Fri, 26 Jun 2026 01:55:05 +0000 (UTC)
Received: from kassi.invalid.is (85-220-33-163.dsl.dynamic.simnet.is [85.220.33.163])
	by vist-zimproxy-05.vist.is (Postfix) with ESMTPSA id 48066207CFA6;
	Fri, 26 Jun 2026 01:55:03 +0000 (UTC)
Date: Fri, 26 Jun 2026 01:54:52 +0000
From: Bjarni Ingi Gislason <bjarniig@simnet.is>
To: netdev@vger.kernel.org
Cc: Debian Bug Tracking System <submit@bugs.debian.org>
Subject: iproute2: trailing whitespace in man pages
Message-ID: <178243847243.6540.10252433987238870483.reportbug@kassi.invalid.is>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="+eA4wM385KTH3mHE"
Content-Disposition: inline
X-Mailer: reportbug 13.2.0+nmu1
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[simnet.is,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[simnet.is:s=sel1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[multipart/mixed,text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	TAGGED_FROM(0.00)[bounces-302081-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:netdev@vger.kernel.org,m:submit@bugs.debian.org,s:lists@lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp];
	FORGED_SENDER(0.00)[bjarniig@simnet.is,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+,1:+,2:+,3:~,4:+];
	RCPT_COUNT_TWO(0.00)[2];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[simnet.is:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bjarniig@simnet.is,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	HAS_ATTACHMENT(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 93D616C9A1F


--+eA4wM385KTH3mHE
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Package: iproute2 (in Debian)
Version: 7.1.0-1
Severity: minor

  Additional remarks.

  Mails from me to "submit@bugs.debian.org" are no longer acknowledged.  A
Debian maintainer told me, that he would contact the mail administrator
about me not wanting to send bugs upstream.

-.-

Dear Maintainer,

   * What led up to the situation?

     Checking for defects with a new version

test-[g|n]roff -mandoc -t -K utf8 -rF0 -rHY=0 -rCHECKSTYLE=0 -ww -z < "man page"

  [Use 

grep -n -e ' $' -e '\\~$' -e ' \\f.$' -e ' \\"' <file>

  to find (most) trailing spaces.]

  ["test-groff" is a script in the repository for "groff"; is not shipped]
(local copy and "troff" slightly changed by me).

  [The fate of "test-nroff" was decided in groff bug #55941.]

   * What was the outcome of this action?

troff:/tmp/gz.roff.tw9zTq:10: warning: trailing whitespace [-w trail]
troff:/tmp/gz.roff.tw9zTq:15: warning: trailing whitespace [-w trail]
troff:/tmp/gz.roff.tw9zTq:20: warning: trailing whitespace [-w trail]
troff:/tmp/gz.roff.tw9zTq:34: warning: trailing whitespace [-w trail]
troff:/tmp/gz.roff.tw9zTq:36: warning: trailing whitespace [-w trail]
troff:/tmp/gz.roff.tw9zTq:38: warning: trailing whitespace [-w trail]
troff:/tmp/gz.roff.tw9zTq:40: warning: trailing whitespace [-w trail]
troff:/tmp/gz.roff.tw9zTq:41: warning: trailing whitespace [-w trail]
troff:/tmp/gz.roff.tw9zTq:42: warning: trailing whitespace [-w trail]
troff:/tmp/gz.roff.tw9zTq:43: warning: trailing whitespace [-w trail]
troff:/tmp/gz.roff.tw9zTq:44: warning: trailing whitespace [-w trail]
troff:/tmp/gz.roff.tw9zTq:45: warning: trailing whitespace [-w trail]
troff:/tmp/gz.roff.tw9zTq:46: warning: trailing whitespace [-w trail]
troff:/tmp/gz.roff.tw9zTq:47: warning: trailing whitespace [-w trail]
troff:/tmp/gz.roff.tw9zTq:48: warning: trailing whitespace [-w trail]
troff:/tmp/gz.roff.tw9zTq:49: warning: trailing whitespace [-w trail]
troff:/tmp/gz.roff.tw9zTq:50: warning: trailing whitespace [-w trail]
troff:/tmp/gz.roff.tw9zTq:55: warning: trailing whitespace [-w trail]
troff:/tmp/gz.roff.tw9zTq:56: warning: trailing whitespace [-w trail]
troff:/tmp/gz.roff.tw9zTq:57: warning: trailing whitespace [-w trail]
/usr/share/man/man8/bridge.8.gz

troff:/tmp/gz.roff.m7ah0F:12: warning: trailing whitespace [-w trail]
/usr/share/man/man8/dcb-app.8.gz

troff:/tmp/gz.roff.lEZOzh:12: warning: trailing whitespace [-w trail]
troff:/tmp/gz.roff.lEZOzh:32: warning: trailing whitespace [-w trail]
/usr/share/man/man8/dcb-apptrust.8.gz

troff:/tmp/gz.roff.WIScEl:12: warning: trailing whitespace [-w trail]
/usr/share/man/man8/dcb-buffer.8.gz

troff:/tmp/gz.roff.lQyzHW:11: warning: trailing whitespace [-w trail]
/usr/share/man/man8/dcb-dcbx.8.gz

troff:/tmp/gz.roff.i604Vp:12: warning: trailing whitespace [-w trail]
troff:/tmp/gz.roff.i604Vp:43: warning: trailing whitespace [-w trail]
/usr/share/man/man8/dcb-ets.8.gz

troff:/tmp/gz.roff.21mI9Z:12: warning: trailing whitespace [-w trail]
troff:/tmp/gz.roff.21mI9Z:37: warning: trailing whitespace [-w trail]
/usr/share/man/man8/dcb-maxrate.8.gz

troff:/tmp/gz.roff.tNIhrB:12: warning: trailing whitespace [-w trail]
troff:/tmp/gz.roff.tNIhrB:38: warning: trailing whitespace [-w trail]
/usr/share/man/man8/dcb-pfc.8.gz

troff:/tmp/gz.roff.rSgJgv:12: warning: trailing whitespace [-w trail]
/usr/share/man/man8/dcb-rewr.8.gz

troff:/tmp/gz.roff.Q8vb3N:11: warning: trailing whitespace [-w trail]
troff:/tmp/gz.roff.Q8vb3N:18: warning: trailing whitespace [-w trail]
troff:/tmp/gz.roff.Q8vb3N:24: warning: trailing whitespace [-w trail]
/usr/share/man/man8/dcb.8.gz

troff:/tmp/gz.roff.IodjFN:12: warning: trailing whitespace [-w trail]
troff:/tmp/gz.roff.IodjFN:17: warning: trailing whitespace [-w trail]
troff:/tmp/gz.roff.IodjFN:32: warning: trailing whitespace [-w trail]
troff:/tmp/gz.roff.IodjFN:34: warning: trailing whitespace [-w trail]
troff:/tmp/gz.roff.IodjFN:36: warning: trailing whitespace [-w trail]
troff:/tmp/gz.roff.IodjFN:54: warning: trailing whitespace [-w trail]
troff:/tmp/gz.roff.IodjFN:123: warning: trailing whitespace [-w trail]
troff:/tmp/gz.roff.IodjFN:133: warning: trailing whitespace [-w trail]
troff:/tmp/gz.roff.IodjFN:149: warning: trailing whitespace [-w trail]
troff:/tmp/gz.roff.IodjFN:175: warning: trailing whitespace [-w trail]
/usr/share/man/man8/devlink-dev.8.gz

troff:/tmp/gz.roff.Nx3P7S:13: warning: trailing whitespace [-w trail]
troff:/tmp/gz.roff.Nx3P7S:18: warning: trailing whitespace [-w trail]
troff:/tmp/gz.roff.Nx3P7S:28: warning: trailing whitespace [-w trail]
troff:/tmp/gz.roff.Nx3P7S:32: warning: trailing whitespace [-w trail]
/usr/share/man/man8/devlink-dpipe.8.gz

troff:/tmp/gz.roff.f7fvNK:12: warning: trailing whitespace [-w trail]
troff:/tmp/gz.roff.f7fvNK:17: warning: trailing whitespace [-w trail]
troff:/tmp/gz.roff.f7fvNK:24: warning: trailing whitespace [-w trail]
troff:/tmp/gz.roff.f7fvNK:66: warning: trailing whitespace [-w trail]
troff:/tmp/gz.roff.f7fvNK:68: warning: trailing whitespace [-w trail]
troff:/tmp/gz.roff.f7fvNK:184: warning: trailing whitespace [-w trail]
troff:/tmp/gz.roff.f7fvNK:188: warning: trailing whitespace [-w trail]
troff:/tmp/gz.roff.f7fvNK:193: warning: trailing whitespace [-w trail]
troff:/tmp/gz.roff.f7fvNK:197: warning: trailing whitespace [-w trail]
/usr/share/man/man8/devlink-health.8.gz

troff:/tmp/gz.roff.hTtjSy:12: warning: trailing whitespace [-w trail]
troff:/tmp/gz.roff.hTtjSy:17: warning: trailing whitespace [-w trail]
troff:/tmp/gz.roff.hTtjSy:24: warning: trailing whitespace [-w trail]
troff:/tmp/gz.roff.hTtjSy:25: warning: trailing whitespace [-w trail]
troff:/tmp/gz.roff.hTtjSy:29: warning: trailing whitespace [-w trail]
troff:/tmp/gz.roff.hTtjSy:50: warning: trailing whitespace [-w trail]
troff:/tmp/gz.roff.hTtjSy:54: warning: trailing whitespace [-w trail]
troff:/tmp/gz.roff.hTtjSy:55: warning: trailing whitespace [-w trail]
troff:/tmp/gz.roff.hTtjSy:56: warning: trailing whitespace [-w trail]
troff:/tmp/gz.roff.hTtjSy:68: warning: trailing whitespace [-w trail]
/usr/share/man/man8/devlink-lc.8.gz

troff:/tmp/gz.roff.soeA6o:12: warning: trailing whitespace [-w trail]
troff:/tmp/gz.roff.soeA6o:17: warning: trailing whitespace [-w trail]
troff:/tmp/gz.roff.soeA6o:22: warning: trailing whitespace [-w trail]
troff:/tmp/gz.roff.soeA6o:24: warning: trailing whitespace [-w trail]
troff:/tmp/gz.roff.soeA6o:29: warning: trailing whitespace [-w trail]
troff:/tmp/gz.roff.soeA6o:35: warning: trailing whitespace [-w trail]
troff:/tmp/gz.roff.soeA6o:50: warning: trailing whitespace [-w trail]
troff:/tmp/gz.roff.soeA6o:66: warning: trailing whitespace [-w trail]
troff:/tmp/gz.roff.soeA6o:68: warning: trailing whitespace [-w trail]
troff:/tmp/gz.roff.soeA6o:69: warning: trailing whitespace [-w trail]
troff:/tmp/gz.roff.soeA6o:71: warning: trailing whitespace [-w trail]
troff:/tmp/gz.roff.soeA6o:74: warning: trailing whitespace [-w trail]
troff:/tmp/gz.roff.soeA6o:77: warning: trailing whitespace [-w trail]
troff:/tmp/gz.roff.soeA6o:80: warning: trailing whitespace [-w trail]
troff:/tmp/gz.roff.soeA6o:83: warning: trailing whitespace [-w trail]
troff:/tmp/gz.roff.soeA6o:86: warning: trailing whitespace [-w trail]
troff:/tmp/gz.roff.soeA6o:91: warning: trailing whitespace [-w trail]
troff:/tmp/gz.roff.soeA6o:101: warning: trailing whitespace [-w trail]
troff:/tmp/gz.roff.soeA6o:127: warning: trailing whitespace [-w trail]
troff:/tmp/gz.roff.soeA6o:167: warning: treating total indentation -72u as zero [-w range]
/usr/share/man/man8/devlink-port.8.gz

troff:/tmp/gz.roff.kYqBeN:12: warning: trailing whitespace [-w trail]
troff:/tmp/gz.roff.kYqBeN:17: warning: trailing whitespace [-w trail]
troff:/tmp/gz.roff.kYqBeN:26: warning: trailing whitespace [-w trail]
/usr/share/man/man8/devlink-rate.8.gz

troff:/tmp/gz.roff.9tHyhr:12: warning: trailing whitespace [-w trail]
troff:/tmp/gz.roff.9tHyhr:17: warning: trailing whitespace [-w trail]
troff:/tmp/gz.roff.9tHyhr:28: warning: trailing whitespace [-w trail]
troff:/tmp/gz.roff.9tHyhr:48: warning: trailing whitespace [-w trail]
/usr/share/man/man8/devlink-region.8.gz

troff:/tmp/gz.roff.9MYeZd:12: warning: trailing whitespace [-w trail]
troff:/tmp/gz.roff.9MYeZd:17: warning: trailing whitespace [-w trail]
/usr/share/man/man8/devlink-resource.8.gz

troff:/tmp/gz.roff.ZhPBEk:12: warning: trailing whitespace [-w trail]
troff:/tmp/gz.roff.ZhPBEk:17: warning: trailing whitespace [-w trail]
troff:/tmp/gz.roff.ZhPBEk:22: warning: trailing whitespace [-w trail]
troff:/tmp/gz.roff.ZhPBEk:23: warning: trailing whitespace [-w trail]
troff:/tmp/gz.roff.ZhPBEk:28: warning: trailing whitespace [-w trail]
troff:/tmp/gz.roff.ZhPBEk:29: warning: trailing whitespace [-w trail]
troff:/tmp/gz.roff.ZhPBEk:31: warning: trailing whitespace [-w trail]
troff:/tmp/gz.roff.ZhPBEk:39: warning: trailing whitespace [-w trail]
troff:/tmp/gz.roff.ZhPBEk:41: warning: trailing whitespace [-w trail]
troff:/tmp/gz.roff.ZhPBEk:43: warning: trailing whitespace [-w trail]
troff:/tmp/gz.roff.ZhPBEk:48: warning: trailing whitespace [-w trail]
troff:/tmp/gz.roff.ZhPBEk:49: warning: trailing whitespace [-w trail]
troff:/tmp/gz.roff.ZhPBEk:51: warning: trailing whitespace [-w trail]
troff:/tmp/gz.roff.ZhPBEk:59: warning: trailing whitespace [-w trail]
troff:/tmp/gz.roff.ZhPBEk:61: warning: trailing whitespace [-w trail]
troff:/tmp/gz.roff.ZhPBEk:63: warning: trailing whitespace [-w trail]
troff:/tmp/gz.roff.ZhPBEk:66: warning: trailing whitespace [-w trail]
troff:/tmp/gz.roff.ZhPBEk:67: warning: trailing whitespace [-w trail]
troff:/tmp/gz.roff.ZhPBEk:69: warning: trailing whitespace [-w trail]
troff:/tmp/gz.roff.ZhPBEk:71: warning: trailing whitespace [-w trail]
/usr/share/man/man8/devlink-sb.8.gz

troff:/tmp/gz.roff.cbJFkk:17: warning: trailing whitespace [-w trail]
troff:/tmp/gz.roff.cbJFkk:79: warning: trailing whitespace [-w trail]
troff:/tmp/gz.roff.cbJFkk:114: warning: trailing whitespace [-w trail]
troff:/tmp/gz.roff.cbJFkk:139: warning: trailing whitespace [-w trail]
troff:/tmp/gz.roff.cbJFkk:143: warning: trailing whitespace [-w trail]
/usr/share/man/man8/devlink-trap.8.gz

troff:/tmp/gz.roff.QOaboD:10: warning: trailing whitespace [-w trail]
troff:/tmp/gz.roff.QOaboD:16: warning: trailing whitespace [-w trail]
/usr/share/man/man8/devlink.8.gz

troff:/tmp/gz.roff.m0E9ov:11: warning: trailing whitespace [-w trail]
troff:/tmp/gz.roff.m0E9ov:19: warning: trailing whitespace [-w trail]
troff:/tmp/gz.roff.m0E9ov:29: warning: trailing whitespace [-w trail]
/usr/share/man/man8/dpll.8.gz

troff:/tmp/gz.roff.hhba1k:12: warning: trailing whitespace [-w trail]
troff:/tmp/gz.roff.hhba1k:19: warning: trailing whitespace [-w trail]
troff:/tmp/gz.roff.hhba1k:24: warning: trailing whitespace [-w trail]
troff:/tmp/gz.roff.hhba1k:29: warning: trailing whitespace [-w trail]
troff:/tmp/gz.roff.hhba1k:31: warning: trailing whitespace [-w trail]
/usr/share/man/man8/genl.8.gz

troff:/tmp/gz.roff.UspeXf:12: warning: trailing whitespace [-w trail]
troff:/tmp/gz.roff.UspeXf:17: warning: trailing whitespace [-w trail]
troff:/tmp/gz.roff.UspeXf:27: warning: trailing whitespace [-w trail]
troff:/tmp/gz.roff.UspeXf:29: warning: trailing whitespace [-w trail]
troff:/tmp/gz.roff.UspeXf:31: warning: trailing whitespace [-w trail]
troff:/tmp/gz.roff.UspeXf:33: warning: trailing whitespace [-w trail]
troff:/tmp/gz.roff.UspeXf:39: warning: trailing whitespace [-w trail]
troff:/tmp/gz.roff.UspeXf:41: warning: trailing whitespace [-w trail]
troff:/tmp/gz.roff.UspeXf:43: warning: trailing whitespace [-w trail]
troff:/tmp/gz.roff.UspeXf:45: warning: trailing whitespace [-w trail]
troff:/tmp/gz.roff.UspeXf:47: warning: trailing whitespace [-w trail]
troff:/tmp/gz.roff.UspeXf:49: warning: trailing whitespace [-w trail]
troff:/tmp/gz.roff.UspeXf:51: warning: trailing whitespace [-w trail]
troff:/tmp/gz.roff.UspeXf:63: warning: trailing whitespace [-w trail]
troff:/tmp/gz.roff.UspeXf:65: warning: trailing whitespace [-w trail]
troff:/tmp/gz.roff.UspeXf:67: warning: trailing whitespace [-w trail]
troff:/tmp/gz.roff.UspeXf:69: warning: trailing whitespace [-w trail]
troff:/tmp/gz.roff.UspeXf:71: warning: trailing whitespace [-w trail]
troff:/tmp/gz.roff.UspeXf:76: warning: trailing whitespace [-w trail]
troff:/tmp/gz.roff.UspeXf:77: warning: trailing whitespace [-w trail]
/usr/share/man/man8/ip-address.8.gz

troff:/tmp/gz.roff.ACnG5f:10: warning: trailing whitespace [-w trail]
troff:/tmp/gz.roff.ACnG5f:15: warning: trailing whitespace [-w trail]
troff:/tmp/gz.roff.ACnG5f:17: warning: trailing whitespace [-w trail]
troff:/tmp/gz.roff.ACnG5f:56: warning: trailing whitespace [-w trail]
/usr/share/man/man8/ip-addrlabel.8.gz

troff:/tmp/gz.roff.5eqgIA:14: warning: trailing whitespace [-w trail]
troff:/tmp/gz.roff.5eqgIA:21: warning: trailing whitespace [-w trail]
troff:/tmp/gz.roff.5eqgIA:27: warning: trailing whitespace [-w trail]
troff:/tmp/gz.roff.5eqgIA:31: warning: trailing whitespace [-w trail]
troff:/tmp/gz.roff.5eqgIA:35: warning: trailing whitespace [-w trail]
troff:/tmp/gz.roff.5eqgIA:39: warning: trailing whitespace [-w trail]
troff:/tmp/gz.roff.5eqgIA:48: warning: trailing whitespace [-w trail]
troff:/tmp/gz.roff.5eqgIA:52: warning: trailing whitespace [-w trail]
troff:/tmp/gz.roff.5eqgIA:56: warning: trailing whitespace [-w trail]
troff:/tmp/gz.roff.5eqgIA:60: warning: trailing whitespace [-w trail]
/usr/share/man/man8/ip-fou.8.gz

troff:/tmp/gz.roff.muormS:10: warning: trailing whitespace [-w trail]
troff:/tmp/gz.roff.muormS:21: warning: trailing whitespace [-w trail]
troff:/tmp/gz.roff.muormS:25: warning: trailing whitespace [-w trail]
troff:/tmp/gz.roff.muormS:49: warning: trailing whitespace [-w trail]
/usr/share/man/man8/ip-ioam.8.gz

troff:/tmp/gz.roff.YZqY4h:12: warning: trailing whitespace [-w trail]
troff:/tmp/gz.roff.YZqY4h:18: warning: trailing whitespace [-w trail]
troff:/tmp/gz.roff.YZqY4h:85: warning: trailing whitespace [-w trail]
troff:/tmp/gz.roff.YZqY4h:232: warning: trailing whitespace [-w trail]
/usr/share/man/man8/ip-l2tp.8.gz

troff:/tmp/gz.roff.x9nPAk:10: warning: trailing whitespace [-w trail]
troff:/tmp/gz.roff.x9nPAk:59: warning: trailing whitespace [-w trail]
troff:/tmp/gz.roff.x9nPAk:67: warning: trailing whitespace [-w trail]
troff:/tmp/gz.roff.x9nPAk:159: warning: trailing whitespace [-w trail]
troff:/tmp/gz.roff.x9nPAk:164: warning: trailing whitespace [-w trail]
troff:/tmp/gz.roff.x9nPAk:186: warning: trailing whitespace [-w trail]
troff:/tmp/gz.roff.x9nPAk:195: warning: trailing whitespace [-w trail]
troff:/tmp/gz.roff.x9nPAk:197: warning: trailing whitespace [-w trail]
troff:/tmp/gz.roff.x9nPAk:223: warning: trailing whitespace [-w trail]
troff:/tmp/gz.roff.x9nPAk:224: warning: trailing whitespace [-w trail]
troff:/tmp/gz.roff.x9nPAk:226: warning: trailing whitespace [-w trail]
troff:/tmp/gz.roff.x9nPAk:227: warning: trailing whitespace [-w trail]
troff:/tmp/gz.roff.x9nPAk:228: warning: trailing whitespace [-w trail]
troff:/tmp/gz.roff.x9nPAk:229: warning: trailing whitespace [-w trail]
troff:/tmp/gz.roff.x9nPAk:230: warning: trailing whitespace [-w trail]
troff:/tmp/gz.roff.x9nPAk:236: warning: trailing whitespace [-w trail]
troff:/tmp/gz.roff.x9nPAk:237: warning: trailing whitespace [-w trail]
troff:/tmp/gz.roff.x9nPAk:248: warning: trailing whitespace [-w trail]
troff:/tmp/gz.roff.x9nPAk:249: warning: trailing whitespace [-w trail]
troff:/tmp/gz.roff.x9nPAk:256: warning: trailing whitespace [-w trail]
/usr/share/man/man8/ip-link.8.gz

troff:/tmp/gz.roff.r9LukD:5: warning: trailing whitespace [-w trail]
troff:/tmp/gz.roff.r9LukD:64: warning: trailing whitespace [-w trail]
troff:/tmp/gz.roff.r9LukD:65: warning: trailing whitespace [-w trail]
troff:/tmp/gz.roff.r9LukD:67: warning: trailing whitespace [-w trail]
troff:/tmp/gz.roff.r9LukD:75: warning: trailing whitespace [-w trail]
troff:/tmp/gz.roff.r9LukD:77: warning: trailing whitespace [-w trail]
troff:/tmp/gz.roff.r9LukD:80: warning: trailing whitespace [-w trail]
troff:/tmp/gz.roff.r9LukD:83: warning: trailing whitespace [-w trail]
troff:/tmp/gz.roff.r9LukD:85: warning: trailing whitespace [-w trail]
/usr/share/man/man8/ip-macsec.8.gz

troff:/tmp/gz.roff.fk7Uej:12: warning: trailing whitespace [-w trail]
/usr/share/man/man8/ip-maddress.8.gz

troff:/tmp/gz.roff.OtuwHM:11: warning: trailing whitespace [-w trail]
troff:/tmp/gz.roff.OtuwHM:17: warning: trailing whitespace [-w trail]
troff:/tmp/gz.roff.OtuwHM:45: warning: trailing whitespace [-w trail]
troff:/tmp/gz.roff.OtuwHM:51: warning: trailing whitespace [-w trail]
troff:/tmp/gz.roff.OtuwHM:57: warning: trailing whitespace [-w trail]
troff:/tmp/gz.roff.OtuwHM:58: warning: trailing whitespace [-w trail]
/usr/share/man/man8/ip-monitor.8.gz

troff:/tmp/gz.roff.DLgQwy:12: warning: trailing whitespace [-w trail]
troff:/tmp/gz.roff.DLgQwy:14: warning: trailing whitespace [-w trail]
troff:/tmp/gz.roff.DLgQwy:16: warning: trailing whitespace [-w trail]
troff:/tmp/gz.roff.DLgQwy:22: warning: trailing whitespace [-w trail]
troff:/tmp/gz.roff.DLgQwy:30: warning: trailing whitespace [-w trail]
troff:/tmp/gz.roff.DLgQwy:32: warning: trailing whitespace [-w trail]
troff:/tmp/gz.roff.DLgQwy:35: warning: trailing whitespace [-w trail]
troff:/tmp/gz.roff.DLgQwy:37: warning: trailing whitespace [-w trail]
troff:/tmp/gz.roff.DLgQwy:39: warning: trailing whitespace [-w trail]
troff:/tmp/gz.roff.DLgQwy:42: warning: trailing whitespace [-w trail]
troff:/tmp/gz.roff.DLgQwy:45: warning: trailing whitespace [-w trail]
troff:/tmp/gz.roff.DLgQwy:52: warning: trailing whitespace [-w trail]
troff:/tmp/gz.roff.DLgQwy:88: warning: trailing whitespace [-w trail]
troff:/tmp/gz.roff.DLgQwy:89: warning: trailing whitespace [-w trail]
troff:/tmp/gz.roff.DLgQwy:92: warning: trailing whitespace [-w trail]
/usr/share/man/man8/ip-mptcp.8.gz

troff:/tmp/gz.roff.Bf2muc:9: warning: trailing whitespace [-w trail]
troff:/tmp/gz.roff.Bf2muc:10: warning: trailing whitespace [-w trail]
troff:/tmp/gz.roff.Bf2muc:11: warning: trailing whitespace [-w trail]
troff:/tmp/gz.roff.Bf2muc:13: warning: trailing whitespace [-w trail]
troff:/tmp/gz.roff.Bf2muc:15: warning: trailing whitespace [-w trail]
troff:/tmp/gz.roff.Bf2muc:17: warning: trailing whitespace [-w trail]
/usr/share/man/man8/ip-mroute.8.gz

troff:/tmp/gz.roff.aIjjMP:12: warning: trailing whitespace [-w trail]
troff:/tmp/gz.roff.aIjjMP:17: warning: trailing whitespace [-w trail]
troff:/tmp/gz.roff.aIjjMP:18: warning: trailing whitespace [-w trail]
troff:/tmp/gz.roff.aIjjMP:20: warning: trailing whitespace [-w trail]
troff:/tmp/gz.roff.aIjjMP:24: warning: trailing whitespace [-w trail]
troff:/tmp/gz.roff.aIjjMP:26: warning: trailing whitespace [-w trail]
troff:/tmp/gz.roff.aIjjMP:27: warning: trailing whitespace [-w trail]
troff:/tmp/gz.roff.aIjjMP:28: warning: trailing whitespace [-w trail]
troff:/tmp/gz.roff.aIjjMP:29: warning: trailing whitespace [-w trail]
troff:/tmp/gz.roff.aIjjMP:30: warning: trailing whitespace [-w trail]
troff:/tmp/gz.roff.aIjjMP:35: warning: trailing whitespace [-w trail]
troff:/tmp/gz.roff.aIjjMP:37: warning: trailing whitespace [-w trail]
troff:/tmp/gz.roff.aIjjMP:39: warning: trailing whitespace [-w trail]
/usr/share/man/man8/ip-neighbour.8.gz

troff:/tmp/gz.roff.sjvvc4:9: warning: trailing whitespace [-w trail]
/usr/share/man/man8/ip-netconf.8.gz

troff:/tmp/gz.roff.bAu8qy:12: warning: trailing whitespace [-w trail]
troff:/tmp/gz.roff.bAu8qy:46: warning: trailing whitespace [-w trail]
/usr/share/man/man8/ip-netns.8.gz

troff:/tmp/gz.roff.nM3cIw:12: warning: trailing whitespace [-w trail]
troff:/tmp/gz.roff.nM3cIw:18: warning: trailing whitespace [-w trail]
troff:/tmp/gz.roff.nM3cIw:19: warning: trailing whitespace [-w trail]
troff:/tmp/gz.roff.nM3cIw:23: warning: trailing whitespace [-w trail]
troff:/tmp/gz.roff.nM3cIw:28: warning: trailing whitespace [-w trail]
troff:/tmp/gz.roff.nM3cIw:40: warning: trailing whitespace [-w trail]
troff:/tmp/gz.roff.nM3cIw:42: warning: trailing whitespace [-w trail]
troff:/tmp/gz.roff.nM3cIw:44: warning: trailing whitespace [-w trail]
troff:/tmp/gz.roff.nM3cIw:46: warning: trailing whitespace [-w trail]
troff:/tmp/gz.roff.nM3cIw:48: warning: trailing whitespace [-w trail]
troff:/tmp/gz.roff.nM3cIw:49: warning: trailing whitespace [-w trail]
troff:/tmp/gz.roff.nM3cIw:53: warning: trailing whitespace [-w trail]
troff:/tmp/gz.roff.nM3cIw:59: warning: trailing whitespace [-w trail]
troff:/tmp/gz.roff.nM3cIw:60: warning: trailing whitespace [-w trail]
troff:/tmp/gz.roff.nM3cIw:62: warning: trailing whitespace [-w trail]
troff:/tmp/gz.roff.nM3cIw:64: warning: trailing whitespace [-w trail]
troff:/tmp/gz.roff.nM3cIw:65: warning: trailing whitespace [-w trail]
troff:/tmp/gz.roff.nM3cIw:67: warning: trailing whitespace [-w trail]
troff:/tmp/gz.roff.nM3cIw:68: warning: trailing whitespace [-w trail]
troff:/tmp/gz.roff.nM3cIw:70: warning: trailing whitespace [-w trail]
/usr/share/man/man8/ip-nexthop.8.gz

troff:/tmp/gz.roff.Kn3w81:12: warning: trailing whitespace [-w trail]
troff:/tmp/gz.roff.Kn3w81:18: warning: trailing whitespace [-w trail]
troff:/tmp/gz.roff.Kn3w81:57: warning: trailing whitespace [-w trail]
troff:/tmp/gz.roff.Kn3w81:59: warning: trailing whitespace [-w trail]
/usr/share/man/man8/ip-ntable.8.gz

troff:/tmp/gz.roff.gv3LBB:12: warning: trailing whitespace [-w trail]
troff:/tmp/gz.roff.gv3LBB:18: warning: trailing whitespace [-w trail]
troff:/tmp/gz.roff.gv3LBB:19: warning: trailing whitespace [-w trail]
troff:/tmp/gz.roff.gv3LBB:33: warning: trailing whitespace [-w trail]
troff:/tmp/gz.roff.gv3LBB:36: warning: trailing whitespace [-w trail]
troff:/tmp/gz.roff.gv3LBB:38: warning: trailing whitespace [-w trail]
troff:/tmp/gz.roff.gv3LBB:40: warning: trailing whitespace [-w trail]
troff:/tmp/gz.roff.gv3LBB:42: warning: trailing whitespace [-w trail]
troff:/tmp/gz.roff.gv3LBB:44: warning: trailing whitespace [-w trail]
troff:/tmp/gz.roff.gv3LBB:46: warning: trailing whitespace [-w trail]
troff:/tmp/gz.roff.gv3LBB:56: warning: trailing whitespace [-w trail]
troff:/tmp/gz.roff.gv3LBB:60: warning: trailing whitespace [-w trail]
troff:/tmp/gz.roff.gv3LBB:62: warning: trailing whitespace [-w trail]
troff:/tmp/gz.roff.gv3LBB:64: warning: trailing whitespace [-w trail]
troff:/tmp/gz.roff.gv3LBB:66: warning: trailing whitespace [-w trail]
troff:/tmp/gz.roff.gv3LBB:68: warning: trailing whitespace [-w trail]
troff:/tmp/gz.roff.gv3LBB:70: warning: trailing whitespace [-w trail]
troff:/tmp/gz.roff.gv3LBB:72: warning: trailing whitespace [-w trail]
troff:/tmp/gz.roff.gv3LBB:74: warning: trailing whitespace [-w trail]
troff:/tmp/gz.roff.gv3LBB:84: warning: trailing whitespace [-w trail]
/usr/share/man/man8/ip-route.8.gz

troff:/tmp/gz.roff.6owsuu:12: warning: trailing whitespace [-w trail]
troff:/tmp/gz.roff.6owsuu:31: warning: trailing whitespace [-w trail]
troff:/tmp/gz.roff.6owsuu:34: warning: trailing whitespace [-w trail]
troff:/tmp/gz.roff.6owsuu:36: warning: trailing whitespace [-w trail]
troff:/tmp/gz.roff.6owsuu:38: warning: trailing whitespace [-w trail]
troff:/tmp/gz.roff.6owsuu:40: warning: trailing whitespace [-w trail]
troff:/tmp/gz.roff.6owsuu:42: warning: trailing whitespace [-w trail]
troff:/tmp/gz.roff.6owsuu:44: warning: trailing whitespace [-w trail]
troff:/tmp/gz.roff.6owsuu:46: warning: trailing whitespace [-w trail]
troff:/tmp/gz.roff.6owsuu:48: warning: trailing whitespace [-w trail]
troff:/tmp/gz.roff.6owsuu:49: warning: trailing whitespace [-w trail]
troff:/tmp/gz.roff.6owsuu:51: warning: trailing whitespace [-w trail]
troff:/tmp/gz.roff.6owsuu:53: warning: trailing whitespace [-w trail]
troff:/tmp/gz.roff.6owsuu:54: warning: trailing whitespace [-w trail]
troff:/tmp/gz.roff.6owsuu:55: warning: trailing whitespace [-w trail]
troff:/tmp/gz.roff.6owsuu:56: warning: trailing whitespace [-w trail]
troff:/tmp/gz.roff.6owsuu:57: warning: trailing whitespace [-w trail]
troff:/tmp/gz.roff.6owsuu:58: warning: trailing whitespace [-w trail]
troff:/tmp/gz.roff.6owsuu:59: warning: trailing whitespace [-w trail]
troff:/tmp/gz.roff.6owsuu:61: warning: trailing whitespace [-w trail]
/usr/share/man/man8/ip-rule.8.gz

troff:/tmp/gz.roff.6yXkbF:10: warning: trailing whitespace [-w trail]
/usr/share/man/man8/ip-sr.8.gz

troff:/tmp/gz.roff.glO7gb:11: warning: trailing whitespace [-w trail]
troff:/tmp/gz.roff.glO7gb:18: warning: trailing whitespace [-w trail]
troff:/tmp/gz.roff.glO7gb:20: warning: trailing whitespace [-w trail]
troff:/tmp/gz.roff.glO7gb:28: warning: trailing whitespace [-w trail]
/usr/share/man/man8/ip-stats.8.gz

troff:/tmp/gz.roff.XiAasB:12: warning: trailing whitespace [-w trail]
troff:/tmp/gz.roff.XiAasB:25: warning: trailing whitespace [-w trail]
troff:/tmp/gz.roff.XiAasB:26: warning: trailing whitespace [-w trail]
/usr/share/man/man8/ip-tcp_metrics.8.gz

troff:/tmp/gz.roff.XtavYp:10: warning: trailing whitespace [-w trail]
/usr/share/man/man8/ip-token.8.gz

troff:/tmp/gz.roff.TS3gWw:12: warning: trailing whitespace [-w trail]
troff:/tmp/gz.roff.TS3gWw:18: warning: trailing whitespace [-w trail]
troff:/tmp/gz.roff.TS3gWw:20: warning: trailing whitespace [-w trail]
troff:/tmp/gz.roff.TS3gWw:25: warning: trailing whitespace [-w trail]
troff:/tmp/gz.roff.TS3gWw:34: warning: trailing whitespace [-w trail]
troff:/tmp/gz.roff.TS3gWw:39: warning: trailing whitespace [-w trail]
troff:/tmp/gz.roff.TS3gWw:41: warning: trailing whitespace [-w trail]
troff:/tmp/gz.roff.TS3gWw:59: warning: trailing whitespace [-w trail]
troff:/tmp/gz.roff.TS3gWw:76: warning: trailing whitespace [-w trail]
troff:/tmp/gz.roff.TS3gWw:81: warning: trailing whitespace [-w trail]
/usr/share/man/man8/ip-tunnel.8.gz

troff:/tmp/gz.roff.5llFkR:11: warning: trailing whitespace [-w trail]
troff:/tmp/gz.roff.5llFkR:28: warning: trailing whitespace [-w trail]
/usr/share/man/man8/ip-vrf.8.gz

troff:/tmp/gz.roff.91zMPC:13: warning: trailing whitespace [-w trail]
troff:/tmp/gz.roff.91zMPC:19: warning: trailing whitespace [-w trail]
troff:/tmp/gz.roff.91zMPC:29: warning: trailing whitespace [-w trail]
troff:/tmp/gz.roff.91zMPC:103: warning: trailing whitespace [-w trail]
troff:/tmp/gz.roff.91zMPC:158: warning: trailing whitespace [-w trail]
troff:/tmp/gz.roff.91zMPC:171: warning: trailing whitespace [-w trail]
troff:/tmp/gz.roff.91zMPC:175: warning: trailing whitespace [-w trail]
troff:/tmp/gz.roff.91zMPC:183: warning: trailing whitespace [-w trail]
troff:/tmp/gz.roff.91zMPC:198: warning: trailing whitespace [-w trail]
troff:/tmp/gz.roff.91zMPC:240: warning: trailing whitespace [-w trail]
troff:/tmp/gz.roff.91zMPC:274: warning: trailing whitespace [-w trail]
troff:/tmp/gz.roff.91zMPC:325: warning: trailing whitespace [-w trail]
troff:/tmp/gz.roff.91zMPC:327: warning: trailing whitespace [-w trail]
troff:/tmp/gz.roff.91zMPC:345: warning: trailing whitespace [-w trail]
troff:/tmp/gz.roff.91zMPC:363: warning: trailing whitespace [-w trail]
troff:/tmp/gz.roff.91zMPC:367: warning: trailing whitespace [-w trail]
troff:/tmp/gz.roff.91zMPC:371: warning: trailing whitespace [-w trail]
troff:/tmp/gz.roff.91zMPC:427: warning: trailing whitespace [-w trail]
troff:/tmp/gz.roff.91zMPC:448: warning: trailing whitespace [-w trail]
troff:/tmp/gz.roff.91zMPC:564: warning: trailing whitespace [-w trail]
/usr/share/man/man8/ip-xfrm.8.gz

troff:/tmp/gz.roff.gY3yJ3:10: warning: trailing whitespace [-w trail]
troff:/tmp/gz.roff.gY3yJ3:16: warning: trailing whitespace [-w trail]
troff:/tmp/gz.roff.gY3yJ3:21: warning: trailing whitespace [-w trail]
troff:/tmp/gz.roff.gY3yJ3:31: warning: trailing whitespace [-w trail]
troff:/tmp/gz.roff.gY3yJ3:39: warning: trailing whitespace [-w trail]
troff:/tmp/gz.roff.gY3yJ3:169: warning: trailing whitespace [-w trail]
troff:/tmp/gz.roff.gY3yJ3:175: warning: trailing whitespace [-w trail]
/usr/share/man/man8/ip.8.gz

troff:/tmp/gz.roff.j0dcO5:10: warning: trailing whitespace [-w trail]
troff:/tmp/gz.roff.j0dcO5:15: warning: trailing whitespace [-w trail]
troff:/tmp/gz.roff.j0dcO5:111: warning: trailing whitespace [-w trail]
troff:/tmp/gz.roff.j0dcO5:112: warning: trailing whitespace [-w trail]
troff:/tmp/gz.roff.j0dcO5:203: warning: trailing whitespace [-w trail]
troff:/tmp/gz.roff.j0dcO5:204: warning: trailing whitespace [-w trail]
/usr/share/man/man8/netshaper.8.gz

troff:/tmp/gz.roff.EOKA9l:12: warning: trailing whitespace [-w trail]
troff:/tmp/gz.roff.EOKA9l:17: warning: trailing whitespace [-w trail]
/usr/share/man/man8/rdma-dev.8.gz

troff:/tmp/gz.roff.j9CeKZ:12: warning: trailing whitespace [-w trail]
troff:/tmp/gz.roff.j9CeKZ:17: warning: trailing whitespace [-w trail]
/usr/share/man/man8/rdma-link.8.gz

troff:/tmp/gz.roff.NBliDx:16: warning: trailing whitespace [-w trail]
/usr/share/man/man8/rdma-monitor.8.gz

troff:/tmp/gz.roff.n7n6Ij:10: warning: trailing whitespace [-w trail]
troff:/tmp/gz.roff.n7n6Ij:15: warning: trailing whitespace [-w trail]
troff:/tmp/gz.roff.n7n6Ij:16: warning: trailing whitespace [-w trail]
troff:/tmp/gz.roff.n7n6Ij:21: warning: trailing whitespace [-w trail]
/usr/share/man/man8/rdma-resource.8.gz

troff:/tmp/gz.roff.zNQGc9:12: warning: trailing whitespace [-w trail]
troff:/tmp/gz.roff.zNQGc9:40: warning: trailing whitespace [-w trail]
troff:/tmp/gz.roff.zNQGc9:85: warning: trailing whitespace [-w trail]
troff:/tmp/gz.roff.zNQGc9:89: warning: trailing whitespace [-w trail]
troff:/tmp/gz.roff.zNQGc9:93: warning: trailing whitespace [-w trail]
troff:/tmp/gz.roff.zNQGc9:97: warning: trailing whitespace [-w trail]
/usr/share/man/man8/rdma-statistic.8.gz

troff:/tmp/gz.roff.w2n0Tg:12: warning: trailing whitespace [-w trail]
troff:/tmp/gz.roff.w2n0Tg:17: warning: trailing whitespace [-w trail]
/usr/share/man/man8/rdma-system.8.gz

troff:/tmp/gz.roff.G452XU:10: warning: trailing whitespace [-w trail]
troff:/tmp/gz.roff.G452XU:16: warning: trailing whitespace [-w trail]
troff:/tmp/gz.roff.G452XU:21: warning: trailing whitespace [-w trail]
troff:/tmp/gz.roff.G452XU:26: warning: trailing whitespace [-w trail]
/usr/share/man/man8/rdma.8.gz

troff:/tmp/gz.roff.8E9eVD:10: warning: trailing whitespace [-w trail]
/usr/share/man/man8/rtmon.8.gz

troff:/tmp/gz.roff.cESP7P:447: warning: trailing whitespace [-w trail]
troff:/tmp/gz.roff.cESP7P:607: warning: trailing whitespace [-w trail]
/usr/share/man/man8/ss.8.gz

troff:/tmp/gz.roff.ux4fN1:9: warning: trailing whitespace [-w trail]
troff:/tmp/gz.roff.ux4fN1:11: warning: trailing whitespace [-w trail]
/usr/share/man/man8/tc-basic.8.gz

troff:/tmp/gz.roff.E5yQLK:9: warning: trailing whitespace [-w trail]
/usr/share/man/man8/tc-cgroup.8.gz

troff:/tmp/gz.roff.xDoFMo:10: warning: trailing whitespace [-w trail]
troff:/tmp/gz.roff.xDoFMo:49: warning: trailing whitespace [-w trail]
/usr/share/man/man8/tc-connmark.8.gz

troff:/tmp/gz.roff.EPr6TY:15: warning: trailing whitespace [-w trail]
troff:/tmp/gz.roff.EPr6TY:26: warning: trailing whitespace [-w trail]
/usr/share/man/man8/tc-csum.8.gz

troff:/tmp/gz.roff.ozliFK:7: warning: trailing whitespace [-w trail]
troff:/tmp/gz.roff.ozliFK:9: warning: trailing whitespace [-w trail]
troff:/tmp/gz.roff.ozliFK:11: warning: trailing whitespace [-w trail]
troff:/tmp/gz.roff.ozliFK:13: warning: trailing whitespace [-w trail]
troff:/tmp/gz.roff.ozliFK:18: warning: trailing whitespace [-w trail]
/usr/share/man/man8/tc-ct.8.gz

troff:/tmp/gz.roff.NlhG4f:34: warning: trailing whitespace [-w trail]
troff:/tmp/gz.roff.NlhG4f:39: warning: trailing whitespace [-w trail]
troff:/tmp/gz.roff.NlhG4f:51: warning: trailing whitespace [-w trail]
/usr/share/man/man8/tc-dualpi2.8.gz

troff:/tmp/gz.roff.AXC30K:14: warning: trailing whitespace [-w trail]
troff:/tmp/gz.roff.AXC30K:20: warning: trailing whitespace [-w trail]
troff:/tmp/gz.roff.AXC30K:22: warning: trailing whitespace [-w trail]
troff:/tmp/gz.roff.AXC30K:33: warning: trailing whitespace [-w trail]
troff:/tmp/gz.roff.AXC30K:73: warning: trailing whitespace [-w trail]
/usr/share/man/man8/tc-ematch.8.gz

troff:/tmp/gz.roff.Xqn4yW:12: warning: trailing whitespace [-w trail]
troff:/tmp/gz.roff.Xqn4yW:13: warning: trailing whitespace [-w trail]
troff:/tmp/gz.roff.Xqn4yW:21: warning: trailing whitespace [-w trail]
troff:/tmp/gz.roff.Xqn4yW:22: warning: trailing whitespace [-w trail]
troff:/tmp/gz.roff.Xqn4yW:24: warning: trailing whitespace [-w trail]
troff:/tmp/gz.roff.Xqn4yW:32: warning: trailing whitespace [-w trail]
troff:/tmp/gz.roff.Xqn4yW:34: warning: trailing whitespace [-w trail]
troff:/tmp/gz.roff.Xqn4yW:36: warning: trailing whitespace [-w trail]
troff:/tmp/gz.roff.Xqn4yW:38: warning: trailing whitespace [-w trail]
troff:/tmp/gz.roff.Xqn4yW:46: warning: trailing whitespace [-w trail]
troff:/tmp/gz.roff.Xqn4yW:47: warning: trailing whitespace [-w trail]
troff:/tmp/gz.roff.Xqn4yW:54: warning: trailing whitespace [-w trail]
troff:/tmp/gz.roff.Xqn4yW:55: warning: trailing whitespace [-w trail]
troff:/tmp/gz.roff.Xqn4yW:56: warning: trailing whitespace [-w trail]
troff:/tmp/gz.roff.Xqn4yW:57: warning: trailing whitespace [-w trail]
/usr/share/man/man8/tc-flow.8.gz

troff:/tmp/gz.roff.SN8HX6:8: warning: trailing whitespace [-w trail]
troff:/tmp/gz.roff.SN8HX6:9: warning: trailing whitespace [-w trail]
troff:/tmp/gz.roff.SN8HX6:11: warning: trailing whitespace [-w trail]
troff:/tmp/gz.roff.SN8HX6:13: warning: trailing whitespace [-w trail]
troff:/tmp/gz.roff.SN8HX6:22: warning: trailing whitespace [-w trail]
troff:/tmp/gz.roff.SN8HX6:24: warning: trailing whitespace [-w trail]
troff:/tmp/gz.roff.SN8HX6:26: warning: trailing whitespace [-w trail]
troff:/tmp/gz.roff.SN8HX6:28: warning: trailing whitespace [-w trail]
troff:/tmp/gz.roff.SN8HX6:29: warning: trailing whitespace [-w trail]
troff:/tmp/gz.roff.SN8HX6:30: warning: trailing whitespace [-w trail]
troff:/tmp/gz.roff.SN8HX6:32: warning: trailing whitespace [-w trail]
troff:/tmp/gz.roff.SN8HX6:34: warning: trailing whitespace [-w trail]
troff:/tmp/gz.roff.SN8HX6:35: warning: trailing whitespace [-w trail]
troff:/tmp/gz.roff.SN8HX6:36: warning: trailing whitespace [-w trail]
troff:/tmp/gz.roff.SN8HX6:38: warning: trailing whitespace [-w trail]
troff:/tmp/gz.roff.SN8HX6:40: warning: trailing whitespace [-w trail]
troff:/tmp/gz.roff.SN8HX6:41: warning: trailing whitespace [-w trail]
troff:/tmp/gz.roff.SN8HX6:42: warning: trailing whitespace [-w trail]
troff:/tmp/gz.roff.SN8HX6:44: warning: trailing whitespace [-w trail]
troff:/tmp/gz.roff.SN8HX6:45: warning: trailing whitespace [-w trail]
/usr/share/man/man8/tc-flower.8.gz

troff:/tmp/gz.roff.75BF9d:69: warning: trailing whitespace [-w trail]
/usr/share/man/man8/tc-fq_codel.8.gz

troff:/tmp/gz.roff.ATqeiC:9: warning: trailing whitespace [-w trail]
/usr/share/man/man8/tc-fw.8.gz

troff:/tmp/gz.roff.0gJmYD:11: warning: trailing whitespace [-w trail]
troff:/tmp/gz.roff.0gJmYD:12: warning: trailing whitespace [-w trail]
troff:/tmp/gz.roff.0gJmYD:21: warning: trailing whitespace [-w trail]
troff:/tmp/gz.roff.0gJmYD:24: warning: trailing whitespace [-w trail]
/usr/share/man/man8/tc-gact.8.gz

troff:/tmp/gz.roff.1ht4Bu:9: warning: trailing whitespace [-w trail]
troff:/tmp/gz.roff.1ht4Bu:11: warning: trailing whitespace [-w trail]
troff:/tmp/gz.roff.1ht4Bu:13: warning: trailing whitespace [-w trail]
troff:/tmp/gz.roff.1ht4Bu:15: warning: trailing whitespace [-w trail]
troff:/tmp/gz.roff.1ht4Bu:16: warning: trailing whitespace [-w trail]
troff:/tmp/gz.roff.1ht4Bu:17: warning: trailing whitespace [-w trail]
troff:/tmp/gz.roff.1ht4Bu:19: warning: trailing whitespace [-w trail]
troff:/tmp/gz.roff.1ht4Bu:22: warning: trailing whitespace [-w trail]
troff:/tmp/gz.roff.1ht4Bu:26: warning: trailing whitespace [-w trail]
troff:/tmp/gz.roff.1ht4Bu:32: warning: trailing whitespace [-w trail]
troff:/tmp/gz.roff.1ht4Bu:36: warning: trailing whitespace [-w trail]
troff:/tmp/gz.roff.1ht4Bu:59: warning: trailing whitespace [-w trail]
troff:/tmp/gz.roff.1ht4Bu:67: warning: trailing whitespace [-w trail]
/usr/share/man/man8/tc-ife.8.gz

troff:/tmp/gz.roff.eEZB5X:8: warning: trailing whitespace [-w trail]
troff:/tmp/gz.roff.eEZB5X:10: warning: trailing whitespace [-w trail]
troff:/tmp/gz.roff.eEZB5X:12: warning: trailing whitespace [-w trail]
/usr/share/man/man8/tc-matchall.8.gz

troff:/tmp/gz.roff.BCTuKt:11: warning: trailing whitespace [-w trail]
troff:/tmp/gz.roff.BCTuKt:15: warning: trailing whitespace [-w trail]
troff:/tmp/gz.roff.BCTuKt:22: warning: trailing whitespace [-w trail]
troff:/tmp/gz.roff.BCTuKt:26: warning: trailing whitespace [-w trail]
troff:/tmp/gz.roff.BCTuKt:30: warning: trailing whitespace [-w trail]
/usr/share/man/man8/tc-mirred.8.gz

troff:/tmp/gz.roff.KuFNwq:8: warning: trailing whitespace [-w trail]
troff:/tmp/gz.roff.KuFNwq:9: warning: trailing whitespace [-w trail]
troff:/tmp/gz.roff.KuFNwq:10: warning: trailing whitespace [-w trail]
troff:/tmp/gz.roff.KuFNwq:14: warning: trailing whitespace [-w trail]
troff:/tmp/gz.roff.KuFNwq:19: warning: trailing whitespace [-w trail]
troff:/tmp/gz.roff.KuFNwq:23: warning: trailing whitespace [-w trail]
troff:/tmp/gz.roff.KuFNwq:25: warning: trailing whitespace [-w trail]
troff:/tmp/gz.roff.KuFNwq:27: warning: trailing whitespace [-w trail]
troff:/tmp/gz.roff.KuFNwq:31: warning: trailing whitespace [-w trail]
troff:/tmp/gz.roff.KuFNwq:35: warning: trailing whitespace [-w trail]
troff:/tmp/gz.roff.KuFNwq:37: warning: trailing whitespace [-w trail]
troff:/tmp/gz.roff.KuFNwq:40: warning: trailing whitespace [-w trail]
troff:/tmp/gz.roff.KuFNwq:57: warning: trailing whitespace [-w trail]
troff:/tmp/gz.roff.KuFNwq:80: warning: trailing whitespace [-w trail]
troff:/tmp/gz.roff.KuFNwq:81: warning: trailing whitespace [-w trail]
/usr/share/man/man8/tc-mpls.8.gz

troff:/tmp/gz.roff.9RiFlD:235: warning: trailing whitespace [-w trail]
troff:/tmp/gz.roff.9RiFlD:237: warning: trailing whitespace [-w trail]
troff:/tmp/gz.roff.9RiFlD:254: warning: trailing whitespace [-w trail]
troff:/tmp/gz.roff.9RiFlD:274: warning: trailing whitespace [-w trail]
troff:/tmp/gz.roff.9RiFlD:282: warning: trailing whitespace [-w trail]
troff:/tmp/gz.roff.9RiFlD:284: warning: trailing whitespace [-w trail]
/usr/share/man/man8/tc-mqprio.8.gz

troff:/tmp/gz.roff.t0JWAM:12: warning: trailing whitespace [-w trail]
troff:/tmp/gz.roff.t0JWAM:22: warning: trailing whitespace [-w trail]
troff:/tmp/gz.roff.t0JWAM:23: warning: trailing whitespace [-w trail]
/usr/share/man/man8/tc-nat.8.gz

troff:/tmp/gz.roff.ZHcyYL:6: warning: trailing whitespace [-w trail]
troff:/tmp/gz.roff.ZHcyYL:14: warning: trailing whitespace [-w trail]
troff:/tmp/gz.roff.ZHcyYL:18: warning: trailing whitespace [-w trail]
troff:/tmp/gz.roff.ZHcyYL:25: warning: trailing whitespace [-w trail]
troff:/tmp/gz.roff.ZHcyYL:26: warning: trailing whitespace [-w trail]
troff:/tmp/gz.roff.ZHcyYL:34: warning: trailing whitespace [-w trail]
troff:/tmp/gz.roff.ZHcyYL:35: warning: trailing whitespace [-w trail]
troff:/tmp/gz.roff.ZHcyYL:37: warning: trailing whitespace [-w trail]
troff:/tmp/gz.roff.ZHcyYL:41: warning: trailing whitespace [-w trail]
troff:/tmp/gz.roff.ZHcyYL:45: warning: trailing whitespace [-w trail]
troff:/tmp/gz.roff.ZHcyYL:47: warning: trailing whitespace [-w trail]
troff:/tmp/gz.roff.ZHcyYL:51: warning: trailing whitespace [-w trail]
troff:/tmp/gz.roff.ZHcyYL:55: warning: trailing whitespace [-w trail]
troff:/tmp/gz.roff.ZHcyYL:56: warning: trailing whitespace [-w trail]
troff:/tmp/gz.roff.ZHcyYL:59: warning: trailing whitespace [-w trail]
troff:/tmp/gz.roff.ZHcyYL:60: warning: trailing whitespace [-w trail]
troff:/tmp/gz.roff.ZHcyYL:63: warning: trailing whitespace [-w trail]
troff:/tmp/gz.roff.ZHcyYL:67: warning: trailing whitespace [-w trail]
troff:/tmp/gz.roff.ZHcyYL:383: warning: trailing whitespace [-w trail]
troff:/tmp/gz.roff.ZHcyYL:387: warning [page 1, line 269]: cannot adjust line in b adjust mode; overset by 4n [-w break]
/usr/share/man/man8/tc-netem.8.gz

troff:/tmp/gz.roff.DJ46bB:12: warning: trailing whitespace [-w trail]
troff:/tmp/gz.roff.DJ46bB:18: warning: trailing whitespace [-w trail]
troff:/tmp/gz.roff.DJ46bB:22: warning: trailing whitespace [-w trail]
troff:/tmp/gz.roff.DJ46bB:29: warning: trailing whitespace [-w trail]
troff:/tmp/gz.roff.DJ46bB:44: warning: trailing whitespace [-w trail]
troff:/tmp/gz.roff.DJ46bB:48: warning: trailing whitespace [-w trail]
troff:/tmp/gz.roff.DJ46bB:53: warning: trailing whitespace [-w trail]
troff:/tmp/gz.roff.DJ46bB:57: warning: trailing whitespace [-w trail]
troff:/tmp/gz.roff.DJ46bB:62: warning: trailing whitespace [-w trail]
troff:/tmp/gz.roff.DJ46bB:63: warning: trailing whitespace [-w trail]
troff:/tmp/gz.roff.DJ46bB:67: warning: trailing whitespace [-w trail]
troff:/tmp/gz.roff.DJ46bB:71: warning: trailing whitespace [-w trail]
troff:/tmp/gz.roff.DJ46bB:77: warning: trailing whitespace [-w trail]
troff:/tmp/gz.roff.DJ46bB:79: warning: trailing whitespace [-w trail]
troff:/tmp/gz.roff.DJ46bB:80: warning: trailing whitespace [-w trail]
/usr/share/man/man8/tc-pedit.8.gz

troff:/tmp/gz.roff.HpJEdr:34: warning: trailing whitespace [-w trail]
/usr/share/man/man8/tc-police.8.gz

troff:/tmp/gz.roff.JYFwIE:9: warning: trailing whitespace [-w trail]
troff:/tmp/gz.roff.JYFwIE:11: warning: trailing whitespace [-w trail]
troff:/tmp/gz.roff.JYFwIE:13: warning: trailing whitespace [-w trail]
troff:/tmp/gz.roff.JYFwIE:15: warning: trailing whitespace [-w trail]
/usr/share/man/man8/tc-route.8.gz

troff:/tmp/gz.roff.TQDw2w:14: warning: trailing whitespace [-w trail]
troff:/tmp/gz.roff.TQDw2w:16: warning: trailing whitespace [-w trail]
troff:/tmp/gz.roff.TQDw2w:19: warning: trailing whitespace [-w trail]
/usr/share/man/man8/tc-sample.8.gz

troff:/tmp/gz.roff.LzdwcT:69: warning: trailing whitespace [-w trail]
/usr/share/man/man8/tc-skbedit.8.gz

troff:/tmp/gz.roff.EeoYee:8: warning: trailing whitespace [-w trail]
troff:/tmp/gz.roff.EeoYee:9: warning: trailing whitespace [-w trail]
troff:/tmp/gz.roff.EeoYee:12: warning: trailing whitespace [-w trail]
troff:/tmp/gz.roff.EeoYee:13: warning: trailing whitespace [-w trail]
troff:/tmp/gz.roff.EeoYee:17: warning: trailing whitespace [-w trail]
troff:/tmp/gz.roff.EeoYee:19: warning: trailing whitespace [-w trail]
troff:/tmp/gz.roff.EeoYee:21: warning: trailing whitespace [-w trail]
troff:/tmp/gz.roff.EeoYee:23: warning: trailing whitespace [-w trail]
troff:/tmp/gz.roff.EeoYee:26: warning: trailing whitespace [-w trail]
/usr/share/man/man8/tc-skbmod.8.gz

troff:/tmp/gz.roff.LaXqMO:8: warning: trailing whitespace [-w trail]
troff:/tmp/gz.roff.LaXqMO:12: warning: trailing whitespace [-w trail]
/usr/share/man/man8/tc-tunnel_key.8.gz

troff:/tmp/gz.roff.0SnZpw:9: warning: trailing whitespace [-w trail]
troff:/tmp/gz.roff.0SnZpw:11: warning: trailing whitespace [-w trail]
troff:/tmp/gz.roff.0SnZpw:13: warning: trailing whitespace [-w trail]
troff:/tmp/gz.roff.0SnZpw:15: warning: trailing whitespace [-w trail]
troff:/tmp/gz.roff.0SnZpw:17: warning: trailing whitespace [-w trail]
troff:/tmp/gz.roff.0SnZpw:19: warning: trailing whitespace [-w trail]
troff:/tmp/gz.roff.0SnZpw:21: warning: trailing whitespace [-w trail]
troff:/tmp/gz.roff.0SnZpw:23: warning: trailing whitespace [-w trail]
troff:/tmp/gz.roff.0SnZpw:25: warning: trailing whitespace [-w trail]
troff:/tmp/gz.roff.0SnZpw:27: warning: trailing whitespace [-w trail]
troff:/tmp/gz.roff.0SnZpw:29: warning: trailing whitespace [-w trail]
troff:/tmp/gz.roff.0SnZpw:31: warning: trailing whitespace [-w trail]
troff:/tmp/gz.roff.0SnZpw:32: warning: trailing whitespace [-w trail]
troff:/tmp/gz.roff.0SnZpw:33: warning: trailing whitespace [-w trail]
troff:/tmp/gz.roff.0SnZpw:37: warning: trailing whitespace [-w trail]
troff:/tmp/gz.roff.0SnZpw:44: warning: trailing whitespace [-w trail]
troff:/tmp/gz.roff.0SnZpw:46: warning: trailing whitespace [-w trail]
troff:/tmp/gz.roff.0SnZpw:51: warning: trailing whitespace [-w trail]
troff:/tmp/gz.roff.0SnZpw:52: warning: trailing whitespace [-w trail]
troff:/tmp/gz.roff.0SnZpw:53: warning: trailing whitespace [-w trail]
/usr/share/man/man8/tc-u32.8.gz

troff:/tmp/gz.roff.ZLTTLY:12: warning: trailing whitespace [-w trail]
troff:/tmp/gz.roff.ZLTTLY:16: warning: trailing whitespace [-w trail]
troff:/tmp/gz.roff.ZLTTLY:20: warning: trailing whitespace [-w trail]
troff:/tmp/gz.roff.ZLTTLY:24: warning: trailing whitespace [-w trail]
troff:/tmp/gz.roff.ZLTTLY:28: warning: trailing whitespace [-w trail]
troff:/tmp/gz.roff.ZLTTLY:30: warning: trailing whitespace [-w trail]
troff:/tmp/gz.roff.ZLTTLY:33: warning: trailing whitespace [-w trail]
/usr/share/man/man8/tc-vlan.8.gz

troff:/tmp/gz.roff.bkv7BO:128: warning: trailing whitespace [-w trail]
troff:/tmp/gz.roff.bkv7BO:129: warning: ignoring escape character before ']' [-w escape]
troff:/tmp/gz.roff.bkv7BO:717: warning: trailing whitespace [-w trail]
troff:/tmp/gz.roff.bkv7BO:723: warning: trailing whitespace [-w trail]
/usr/share/man/man8/tc.8.gz

troff:/tmp/gz.roff.My0dwn:57: warning: trailing whitespace [-w trail]
/usr/share/man/man8/tipc-bearer.8.gz

troff:/tmp/gz.roff.bYd25b:18: warning: trailing whitespace [-w trail]
troff:/tmp/gz.roff.bYd25b:27: warning: trailing whitespace [-w trail]
troff:/tmp/gz.roff.bYd25b:28: warning: trailing whitespace [-w trail]
troff:/tmp/gz.roff.bYd25b:30: warning: trailing whitespace [-w trail]
troff:/tmp/gz.roff.bYd25b:32: warning: trailing whitespace [-w trail]
troff:/tmp/gz.roff.bYd25b:42: warning: trailing whitespace [-w trail]
troff:/tmp/gz.roff.bYd25b:53: warning: trailing whitespace [-w trail]
troff:/tmp/gz.roff.bYd25b:62: warning: trailing whitespace [-w trail]
troff:/tmp/gz.roff.bYd25b:66: warning: trailing whitespace [-w trail]
/usr/share/man/man8/tipc-link.8.gz

troff:/tmp/gz.roff.rs4kL6:17: warning: trailing whitespace [-w trail]
/usr/share/man/man8/tipc-media.8.gz

troff:/tmp/gz.roff.z8m3fR:15: warning: trailing whitespace [-w trail]
troff:/tmp/gz.roff.z8m3fR:19: warning: trailing whitespace [-w trail]
troff:/tmp/gz.roff.z8m3fR:23: warning: trailing whitespace [-w trail]
/usr/share/man/man8/tipc-node.8.gz

an.tmac:/tmp/gz.roff.9VgwLV:30: warning: cannot call .SS while an input trap is pending
an.tmac:/tmp/gz.roff.9VgwLV:34: warning: cannot call .SS while an input trap is pending
/usr/share/man/man8/tipc-socket.8.gz

troff:/tmp/gz.roff.rBSHKg:14: warning: trailing whitespace [-w trail]
troff:/tmp/gz.roff.rBSHKg:19: warning: trailing whitespace [-w trail]
/usr/share/man/man8/tipc.8.gz

troff:/tmp/gz.roff.gPfIxK:11: warning: trailing whitespace [-w trail]
troff:/tmp/gz.roff.gPfIxK:12: warning: trailing whitespace [-w trail]
troff:/tmp/gz.roff.gPfIxK:17: warning: trailing whitespace [-w trail]
/usr/share/man/man8/vdpa-dev.8.gz

troff:/tmp/gz.roff.wHzGiy:11: warning: trailing whitespace [-w trail]
troff:/tmp/gz.roff.wHzGiy:16: warning: trailing whitespace [-w trail]
/usr/share/man/man8/vdpa-mgmtdev.8.gz

troff:/tmp/gz.roff.qSwXBM:10: warning: trailing whitespace [-w trail]
/usr/share/man/man8/vdpa.8.gz

   * What outcome did you expect instead?

     No output (no warnings).

-.-

  General remarks and further material, if a diff-file exist, are in the
attachments.


-- System Information:
Debian Release: forky/sid
  APT prefers testing
  APT policy: (500, 'testing')
Architecture: amd64 (x86_64)

Kernel: Linux 7.0.12+deb14.1-amd64 (SMP w/2 CPU threads; PREEMPT)
Locale: LANG=is_IS.iso88591, LC_CTYPE=is_IS.iso88591 (charmap=ISO-8859-1), LANGUAGE not set
Shell: /bin/sh linked to /usr/bin/dash
Init: sysvinit (via /sbin/init)

Versions of packages iproute2 depends on:
ii  debconf [debconf-2.0]  1.5.92
ii  libbpf1                1:1.7.0-1
ii  libc6                  2.42-17
ii  libcap2                1:2.78-1
ii  libcap2-bin            1:2.78-1
ii  libdb5.3t64            5.3.28+dfsg2-11+b1
ii  libelf1t64             0.195-1
ii  libmnl0                1.0.5-3+b2
ii  libselinux1            3.10-1
ii  libtirpc3t64           1.3.7+ds-1
ii  libxtables12           1.8.13-1

iproute2 recommends no packages.

Versions of packages iproute2 suggests:
ii  python3  3.13.9-3+b1

-- debconf information excluded

--+eA4wM385KTH3mHE
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=general.bugs

  Check the output from "lintian" in the Debian distribution.

  Any program (person), that produces man pages, should check the output
for defects by using (both groff and nroff)

[gn]roff -mandoc -t -ww -b -z -K utf8 <man page>

  To find most trailing spaces use

grep -n -e ' $' -e ' \\f.$' -e ' \\"' <man page>

  The same goes for man pages that are used as an input.

-.-

  For a style guide use

  mandoc -T lint

-.-

  For general input conventions consult the man page "nroff(7)" (item
"Input conventions") or the Texinfo manual about the same item.

-.-

  Any "autogenerator" should check its products with the above mentioned
'groff', 'mandoc', and additionally with 'nroff ...'.

  It should also check its input files for too long (> 80) lines.

  This is just a simple quality control measure.

  The "autogenerator" may have to be corrected to get a better man page,
the source file may, and any additional file may.

-.-

  Common defects:

  Not removing trailing spaces (in in- and output).
  The reason for these trailing spaces should be found and eliminated.

  "git" has a "tool" to point out whitespace,
see for example "git-apply(1)" and git-config(1)")

-.-

  Not beginning each input sentence on a new line.

Line length and patch size should thus be reduced when that has been fixed.

  The script "reportbug" uses 'quoted-printable' encoding when a line is
longer than 1024 characters in an 'ascii' file.

  See man-pages(7), item "semantic newline".

-.-

The difference between the formatted output of the original
and patched file can be seen with:

  nroff -mandoc <file1> > <out1>
  nroff -mandoc <file2> > <out2>
  diff -d -u <out1> <out2>

and for groff, using

\"printf '%s\n%s\n' '.kern 0' '.ss 12 0' | groff -mandoc -Z - \"

instead of 'nroff -mandoc'

  Add the option '-t', if the file contains a table.

  Read the output from 'diff -d -u ...' with 'less -R' or similar.

-.-.

  If 'man' (man-db) is used to check the manual for warnings,
the following must be set:

  The option "-warnings=w"

  The environmental variable:

export MAN_KEEP_STDERR=yes (or any non-empty value)

  or

  (produce only warnings):

export MANROFFOPT="-ww -b -z"

export MAN_KEEP_STDERR=yes (or any non-empty value)

-.-

--+eA4wM385KTH3mHE
Content-Type: message/rfc822
Content-Disposition: attachment; filename=trailing.whitespace

Subject: clean files of trailing whitespace

  Trailing whitespace is so unnecessary, that its presence may be removed
before files containing it are distributed.

  Some programs have a tool to point out its presence, like

gcc

  with option "-Wtrailing-whitespace"

git
  with option "apply --whitespace=..."

  and in ".git/config"

[core]
	whitespace=...

grep

  with option -e '[[:blank:]]$'

less

  with command "/ $"

mandoc -T lint

  default action

--+eA4wM385KTH3mHE--

