Return-Path: <netdev+bounces-279873-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YAAbAllw5mmBwAEAu9opvQ
	(envelope-from <netdev+bounces-279873-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 20 Apr 2026 20:28:41 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CD2A432D63
	for <lists+netdev@lfdr.de>; Mon, 20 Apr 2026 20:28:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D5C5431EC770
	for <lists+netdev@lfdr.de>; Mon, 20 Apr 2026 17:03:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED30937DEAB;
	Mon, 20 Apr 2026 17:03:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="fzdYUAzB"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yx1-f51.google.com (mail-yx1-f51.google.com [74.125.224.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17A5537CD53
	for <netdev@vger.kernel.org>; Mon, 20 Apr 2026 17:03:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776704606; cv=pass; b=CcaySUGUlKDy9ItNd97he5hXj1BHmrqDCjNkc5w9IE6je05BWNH+WOUW4vzC4+2J9mpITTsHcDIHkAwBpheP1KKUP2wGXrZviqa3FNzcZ7SsALDVz/9+WJ9PGSwsBAXd6Rg7dxFLIwukUbYbYHyEuABQqChp113pb12EhdEbFxE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776704606; c=relaxed/simple;
	bh=MY8cWEKzzznpHqY2ZL9obKtvFQwLdK0P2oXtkA1iJr8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MtPZDkUy81Ug7qljuAKoMoRi6+cjPb+t9GSTkBLKO3EC4jMwdtx2eVtFlpURJUypGjjlb7EKTxxnyrse5361/e+Dx1g6FQ6B+QeQO0EjxtCbyhEoA84kd83EHoiD7NlCEZSpFP1qusjRjdWOxiwQ5iAeMrpTei75lf+uVR5nOOQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=fzdYUAzB; arc=pass smtp.client-ip=74.125.224.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-yx1-f51.google.com with SMTP id 956f58d0204a3-6501418152cso2966178d50.0
        for <netdev@vger.kernel.org>; Mon, 20 Apr 2026 10:03:23 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776704603; cv=none;
        d=google.com; s=arc-20240605;
        b=HdgbxyAMTn3NVMXz5PvO58wkS4ZFyh0OlehbMYl8S0feGhANTQFIZp4X9fuoKou9qd
         4t/932dawY6ZMkGYSMywiLenrfppu4uZrKQD2uYEKLLBvommHGDvxbpFkGa+0fQV+ylQ
         +Of682i8/npsaDO7MlqebTc9tVw9fg6lLrNtzbsTOer4DqLaWrqPRZi96VyJt6HtnDh4
         AFirK8Ee4kMZbB4ZO0su6MVsvMJGqR02h76lb+OBy3LR1GjKkY25FgJ82j7fkIVB2pmG
         iNFKYYJZqZGVL1hWMSx8TejnsRV9n41VVeuHqTp4k+h0lbKbXskXUdUTmeWic4Jls/XM
         /evA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=QuwHzur0DyTT6fAN7548X05vvqlUKr6sImf2XcXe9sE=;
        fh=2PuVfai9Jgn126RKvOco0B4FvVxSLlNrE0I44YRVa8I=;
        b=irXetQz4vj1mp1KG+EW1AxG5MA9KzdAeO0qE73FiR3YFF4nRULR9/56GhQCakjewZ9
         s7DHKGtVaRMceyhZeP6chcvab+lka+V/DVhDB/q1raDvOnfbXcAMzk1AOavcjv3nxvbq
         Ji+rMPy5hPAkEvVV0/nJCUudl7fEWMbyK/wk8TKGJVCOsijyW1dSKb05oL7l7mgrDQsW
         r7nBrO+DqkFfGv4uHHVp2NrBx/3I/MwFpqJy9XVyqYbPHJCs8X/J/COoYc7wm/JQ/BD0
         ZuRAD7AkG8CN3a+UIWexaOZUtTbWAhAPElHT5i1LDHVowt5X5m4Nn/1dGbAkrtkBWOmt
         oCNA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1776704603; x=1777309403; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QuwHzur0DyTT6fAN7548X05vvqlUKr6sImf2XcXe9sE=;
        b=fzdYUAzB25VyAQUlM195lS0A5tRyWmxhZtCVRmSN+VymgpXmf+nfVmsXaGdueI+4ZN
         cRDK/OmokmnXOjGkGBc/SAE4990vxc7KTiIrYSSLyS6ujv/kkvqUDaycunGU0JMwB4B5
         ZlhfRi+TKqzD5yykXpyrKDag8B617STfvqhmehdi0COReaYHkha1pLhR45e258ZcQYGW
         AHRQ7Ay1zvpwEqHnV+7tCzfSOM/PqJO0Eb2KV6OyKwuNrrw/Jm0imXqQaQaqwEhsr0bZ
         PJ9IzHQWvAoLIDvrO+8Boz2O8vSU/I8X8Fya83JISHAF9xNkZb8aLl2/KzLjWnjbtMxj
         un9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776704603; x=1777309403;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=QuwHzur0DyTT6fAN7548X05vvqlUKr6sImf2XcXe9sE=;
        b=N8Q1G/6aYkvIfPykzFL+QMuJ5STrS0osHUws9MSwUnAoqw3WuQ76/+8KRVveEwdFM/
         Cj+4AkgiN1kTkzJF2p692lZaJRySNAnkveOiFoeRh8SDUtW5pd64ut/mxVJCnke+ytTR
         adU3rlQeg8qOQtZV2vxEQHCQOPzp613apsmE6o5KspGUkd4f9dbOBKscV8KA7siL4/NM
         bs+v/zLZ53fHqhZjK5n9iV/rIwZbijH11+2mJXS/ev7PFafDbGmctbGlLiv7M3krRofC
         BgRtJRo8YLatV1yop0WKxrekBV7HwROzKe/60vQsN5fedcwazGFmLD/4Qr7thedcU+R4
         0hOg==
X-Forwarded-Encrypted: i=1; AFNElJ99VzJ/2kolaM/+r4XlW6dF67q2+B63GpDBPqFz6T1UFx3mZ+jG9qZiamjLOj28WnZBsJWwpu4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxx+Iq5UOMfIWDJch2gZ9Ut7bk5IKd7Ni2+NjshLVDRCE0DCT1M
	/qDSaP7ODuDGqCF7akp6w6s03/Sxi7Fj87w9nnj+SZejRNXtJaIZW87O34TTpdcIBI4agu6yBvt
	eueEezqr7PCVgI20v4YGNgUhzldwiW8XJYWXkZBmo
X-Gm-Gg: AeBDietd31Ym3zql3agWo9BQ/f14Q/K6qgbB6BbPVfYyAsBSIEQBrnY1dhn+i7SQLwe
	JmdWNUNFeA3evv454s2bHA5jEqzQ0QEZB0smoXVcT/JJUB02ZwkAog3XxxJCcEwjk6tcZKt9SD2
	BOPeEWdAsbWh6ZwXstESxdKD3Eh9TL9C6VlI+GTNAdQjZGJsw+dErAhtRW7KCddtkVGTJg7lCKp
	ilf4tnmnqFOmY9JlmZJv6AEM3uUzUZjA8HNSKO84pT4Mfq2Q1Krx6VDNMDc1a3B73/ZmO9GAuai
	ktAWF9SvctJylwKUnRRe8nBrW86HPRUE/EgF7PnZ+F9e/z8w1njezFTwtS4=
X-Received: by 2002:a05:690e:124a:b0:650:1bc2:7e18 with SMTP id
 956f58d0204a3-65310803466mr14402341d50.1.1776704601042; Mon, 20 Apr 2026
 10:03:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260419192555.3631327-1-boolli@google.com> <PH7PR11MB59834C3C7785D1E69B7E954EF32F2@PH7PR11MB5983.namprd11.prod.outlook.com>
In-Reply-To: <PH7PR11MB59834C3C7785D1E69B7E954EF32F2@PH7PR11MB5983.namprd11.prod.outlook.com>
From: Li Li <boolli@google.com>
Date: Mon, 20 Apr 2026 10:03:08 -0700
X-Gm-Features: AQROBzCRU8m1PocV3KnbRH0zjFz61ZPVhxSInF_uNWzvauXiSpZzp7JJjroMqgY
Message-ID: <CAODvEq41VxdJ+nmM49eNo4d4VYBoDF69hzQUe8dUP9RoAuxxGA@mail.gmail.com>
Subject: Re: [Intel-wired-lan] [PATCH] idpf: do not perform flow ops when
 netdev is detached
To: "Kwapulinski, Piotr" <piotr.kwapulinski@intel.com>
Cc: "Nguyen, Anthony L" <anthony.l.nguyen@intel.com>, 
	"Kitszel, Przemyslaw" <przemyslaw.kitszel@intel.com>, "David S. Miller" <davem@davemloft.net>, 
	Jakub Kicinski <kuba@kernel.org>, Eric Dumazet <edumazet@google.com>, 
	"intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>, 
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, David Decotigny <decot@google.com>, 
	"Singhai, Anjali" <anjali.singhai@intel.com>, 
	"Samudrala, Sridhar" <sridhar.samudrala@intel.com>, Brian Vazquez <brianvv@google.com>, 
	"Tantilov, Emil S" <emil.s.tantilov@intel.com>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [7.34 / 15.00];
	URIBL_BLACK(7.50)[osuosl.org:email];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	BAD_REP_POLICIES(0.10)[];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	R_DKIM_ALLOW(0.00)[google.com:s=20251104];
	TAGGED_FROM(0.00)[bounces-279873-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	GREYLIST(0.00)[pass,meta];
	MIME_TRACE(0.00)[0:+];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	DMARC_POLICY_ALLOW(0.00)[google.com,reject];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	NEURAL_HAM(-0.00)[-0.828];
	FROM_NEQ_ENVFROM(0.00)[boolli@google.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[google.com:+];
	TAGGED_RCPT(0.00)[netdev];
	ARC_ALLOW(0.00)[subspace.kernel.org:s=arc-20240116:i=2];
	R_SPF_ALLOW(0.00)[+ip6:2600:3c0a:e001:db::/64:c];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,davemloft.net:email,mail.gmail.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 5CD2A432D63
X-Rspamd-Action: add header
X-Rspamd-Server: lfdr
X-Spam: Yes

On Mon, Apr 20, 2026 at 1:23=E2=80=AFAM Kwapulinski, Piotr
<piotr.kwapulinski@intel.com> wrote:
>
> >-----Original Message-----
> >From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of =
Li Li via Intel-wired-lan
> >Sent: Sunday, April 19, 2026 9:26 PM
> >To: Nguyen, Anthony L <anthony.l.nguyen@intel.com>; Kitszel, Przemyslaw =
<przemyslaw.kitszel@intel.com>; David S. Miller <davem@davemloft.net>; Jaku=
b Kicinski <kuba@kernel.org>; Eric Dumazet <edumazet@google.com>; intel-wir=
ed-lan@lists.osuosl.org
> >Cc: netdev@vger.kernel.org; linux-kernel@vger.kernel.org; David Decotign=
y <decot@google.com>; Singhai, Anjali <anjali.singhai@intel.com>; Samudrala=
, Sridhar <sridhar.samudrala@intel.com>; Brian Vazquez <brianvv@google.com>=
; Li Li <boolli@google.com>; Tantilov, Emil S <emil.s.tantilov@intel.com>
> >Subject: [Intel-wired-lan] [PATCH] idpf: do not perform flow ops when ne=
tdev is detached
> >
> >Even though commit 2e281e1155fc ("idpf: detach and close netdevs while h=
andling a reset") prevents ethtool -N/-n operations to operate on detached =
netdevs, we found that out-of-tree workflows like OpenOnload can bypass eth=
tool core locks and call idpf_set_rxnfc directly during an idpf HW reset. W=
hen this happens, we could get kernel crashes like the following:
> >
> >[ 4045.787439] BUG: kernel NULL pointer dereference, address: 0000000000=
000070 [ 4045.794420] #PF: supervisor read access in kernel mode [ 4045.799=
580] #PF: error_code(0x0000) - not-present page [ 4045.804739] PGD 0 [ 4045=
.806772] Oops: Oops: 0000 [#1] SMP NOPTI ...
> >[ 4045.836425] Workqueue: onload-wqueue oof_do_deferred_work_fn [onload]=
 [ 4045.842926] RIP: 0010:idpf_del_flow_steer+0x24/0x170 [idpf] ...
> >[ 4045.946323] Call Trace:
> >[ 4045.948796]  <TASK>
> >[ 4045.950915]  ? show_trace_log_lvl+0x1b0/0x2f0 [ 4045.955293]  ? show_=
trace_log_lvl+0x1b0/0x2f0 [ 4045.959672]  ? idpf_set_rxnfc+0x6f/0x80 [idpf]=
 [ 4045.964142]  ? __die_body.cold+0x8/0x12 [ 4045.968000]  ? page_fault_oo=
ps+0x148/0x160 [ 4045.972117]  ? exc_page_fault+0x6f/0x160 [ 4045.976060]  =
? asm_exc_page_fault+0x22/0x30 [ 4045.980262]  ? idpf_del_flow_steer+0x24/0=
x170 [idpf] [ 4045.985245]  idpf_set_rxnfc+0x6f/0x80 [idpf] [ 4045.989535] =
 af_xdp_filter_remove+0x7c/0xb0 [sfc_resource] [ 4045.995069]  oo_hw_filter=
_clear_hwports+0x6f/0xa0 [onload] [ 4046.000589]  oo_hw_filter_update+0x65/=
0x210 [onload] [ 4046.005587]  oof_hw_filter_update.constprop.0+0xe7/0x140 =
[onload] [ 4046.011716]  oof_manager_update_all_filters+0xad/0x270 [onload]=
 [ 4046.017671]  __oof_do_deferred_work+0x15e/0x190 [onload] [ 4046.023014]=
  oof_do_deferred_work+0x2c/0x40 [onload] [ 4046.028018]  oof_do_deferred_w=
ork_fn+0x12/0x30 [onload] [ 4046.033277]  process_one_work+0x174/0x330 [ 40=
46.037304]  worker_thread+0x246/0x390 [ 4046.041074]  ? __pfx_worker_thread=
+0x10/0x10 [ 4046.045364]  kthread+0xf6/0x240 [ 4046.048530]  ? __pfx_kthre=
ad+0x10/0x10 [ 4046.052297]  ret_from_fork+0x2d/0x50 [ 4046.055896]  ? __pf=
x_kthread+0x10/0x10 [ 4046.059664]  ret_from_fork_asm+0x1a/0x30 [ 4046.0636=
13]  </TASK>
> >
> >To prevent this, we need to add checks in idpf_set_rxnfc and idpf_get_rx=
nfc to error out if the netdev is already detached.
> >
> >Tested: implemented the following patch to synthetically force idpf into=
 a HW reset:
> >
> >diff --git a/drivers/net/ethernet/intel/idpf/idpf_txrx.c b/drivers/net/e=
thernet/intel/idpf/idpf_txrx.c
> >index 4fc0bb14c5b1..27476d57bcf0 100644
> >--- a/drivers/net/ethernet/intel/idpf/idpf_txrx.c
> >+++ b/drivers/net/ethernet/intel/idpf/idpf_txrx.c
> >@@ -10,6 +10,9 @@
> > #define idpf_tx_buf_next(buf)         (*(u32 *)&(buf)->priv)
> > LIBETH_SQE_CHECK_PRIV(u32);
> >
> >+static bool SIMULATE_TX_TIMEOUT;
> >+module_param(SIMULATE_TX_TIMEOUT, bool, 0644);
> >+
> > /**
> >  * idpf_chk_linearize - Check if skb exceeds max descriptors per packet
> >  * @skb: send buffer
> >@@ -46,6 +49,8 @@ void idpf_tx_timeout(struct net_device *netdev, unsign=
ed int txqueue)
> >
> >       adapter->tx_timeout_count++;
> >
> >+      SIMULATE_TX_TIMEOUT =3D false;
> >+
> >       netdev_err(netdev, "Detected Tx timeout: Count %d, Queue %d\n",
> >                  adapter->tx_timeout_count, txqueue);
> >       if (!idpf_is_reset_in_prog(adapter)) { @@ -2225,6 +2230,8 @@ stat=
ic bool idpf_tx_clean_complq(struct idpf_compl_queue *complq, int budget,
> >                       goto fetch_next_desc;
> >               }
> >               tx_q =3D complq->txq_grp->txqs[rel_tx_qid];
> >+              if (unlikely(SIMULATE_TX_TIMEOUT && (tx_q->idx % 2 =3D=3D=
 1)))
> >+                      goto fetch_next_desc;
> >
> >               /* Determine completion type */
> >               ctype =3D le16_get_bits(tx_desc->common.qid_comptype_gen,
> >diff --git a/drivers/net/ethernet/intel/idpf/idpf_virtchnl.c b/drivers/n=
et/ethernet/intel/idpf/idpf_virtchnl.c
> >index be66f9b2e101..ba5da2a86c15 100644
> >--- a/drivers/net/ethernet/intel/idpf/idpf_virtchnl.c
> >+++ b/drivers/net/ethernet/intel/idpf/idpf_virtchnl.c
> >@@ -8,6 +8,9 @@
> > #include "idpf_virtchnl.h"
> > #include "idpf_ptp.h"
> >
> >+static bool VIRTCHNL_FAILED;
> >+module_param(VIRTCHNL_FAILED, bool, 0644);
> >+
> > /**
> >  * struct idpf_vc_xn_manager - Manager for tracking transactions
> >  * @ring: backing and lookup for transactions @@ -3496,6 +3499,11 @@ in=
t idpf_vc_core_init(struct idpf_adapter *adapter)
> >               switch (adapter->state) {
> >               case __IDPF_VER_CHECK:
> >                       err =3D idpf_send_ver_msg(adapter);
> >+
> >+                      if (unlikely(VIRTCHNL_FAILED)) {
> >+                              err =3D -EIO;
> >+                      }
> Please remove redundant parenthesis
> Piotr

Hi Piotr,

The block you are commenting on is not part of the patch; it's just a
block of test code in the commit message I used to reproduce the
failures.

Thanks!

>
> >+
> >                       switch (err) {
> >                       case 0:
> >                               /* success, move state machine forward */
> >
> >And tested by writing 1 to /sys/module/idpf/parameters/VIRTCHNL_FAILED
> >and /sys/module/idpf/parameters/SIMULATE_TX_TIMEOUT, and running
> >idpf_get_rxnfc() right after the HW reset.
> >
> >Without the patch: encountered NULL pointer and kernel crash.
> >
> >With the patch: no crashes.
> >
> >Fixes: 2e281e1155fc ("idpf: detach and close netdevs while handling a re=
set")
> >Signed-off-by: Li Li <boolli@google.com>
> >---
> > drivers/net/ethernet/intel/idpf/idpf_ethtool.c | 6 ++++++
> > 1 file changed, 6 insertions(+)
> >
> >diff --git a/drivers/net/ethernet/intel/idpf/idpf_ethtool.c b/drivers/ne=
t/ethernet/intel/idpf/idpf_ethtool.c
> >index bb99d9e7c65d..8368a7e6a754 100644
> >--- a/drivers/net/ethernet/intel/idpf/idpf_ethtool.c
> >+++ b/drivers/net/ethernet/intel/idpf/idpf_ethtool.c
> >@@ -43,6 +43,9 @@ static int idpf_get_rxnfc(struct net_device *netdev, s=
truct ethtool_rxnfc *cmd,
> >       unsigned int cnt =3D 0;
> >       int err =3D 0;
> >
> >+      if (!netdev || !netif_device_present(netdev))
> >+              return -ENODEV;
> >+
> >       idpf_vport_ctrl_lock(netdev);
> >       vport =3D idpf_netdev_to_vport(netdev);
> >       vport_config =3D np->adapter->vport_config[np->vport_idx];
> >@@ -349,6 +352,9 @@ static int idpf_set_rxnfc(struct net_device *netdev,=
 struct ethtool_rxnfc *cmd)  {
> >       int ret =3D -EOPNOTSUPP;
> >
> >+      if (!netdev || !netif_device_present(netdev))
> >+              return -ENODEV;
> >+
> >       idpf_vport_ctrl_lock(netdev);
> >       switch (cmd->cmd) {
> >       case ETHTOOL_SRXCLSRLINS:
> >--
> >2.54.0.rc1.513.gad8abe7a5a-goog

