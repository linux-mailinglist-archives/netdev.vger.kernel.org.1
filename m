Return-Path: <netdev+bounces-268834-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UOxZMkbuuWnPPgIAu9opvQ
	(envelope-from <netdev+bounces-268834-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 18 Mar 2026 01:13:58 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 6EBBD2B494B
	for <lists+netdev@lfdr.de>; Wed, 18 Mar 2026 01:13:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id C6D64302408C
	for <lists+netdev@lfdr.de>; Wed, 18 Mar 2026 00:13:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D17E97FBAC;
	Wed, 18 Mar 2026 00:13:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="QJpi8hKm"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yx1-f41.google.com (mail-yx1-f41.google.com [74.125.224.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C128125B2
	for <netdev@vger.kernel.org>; Wed, 18 Mar 2026 00:13:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773792836; cv=pass; b=Yw0+cnSBMkTkiiOjUgQPiMm0qc3YeYfOrN/hHzVFHElllG+tsM3W5qvAR5OQjVWmj+RxTJkLjq156A7/7uwzcTXPWOghAgt4K9YKaSVlmGHw8M4JrlejXRonALo2dcm8s/Qu0Cs59vItGt5CtHEMlTt0bePK6UKQ5P4acddOeLg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773792836; c=relaxed/simple;
	bh=1dlBnp6Q0uDDUW6pxd7bhUV/OtX8ZFdk+vReX36VBAs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=E1MmylI2MXubVRw+ssD+DETvJbURLWM2c35agva9yXpRDSPC5KYq95sugutbV3pli47gM+IIpn+06Wb4WXB27AuzXKQMcwe8Kiz3JETPZMESnCRhj5jMwQpBMT7zrxn2sCY4tTZ176g8gCsD7FGlk6497k4ObjWbSXha4bpvr1A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=QJpi8hKm; arc=pass smtp.client-ip=74.125.224.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-yx1-f41.google.com with SMTP id 956f58d0204a3-64c9a398bc7so7125865d50.2
        for <netdev@vger.kernel.org>; Tue, 17 Mar 2026 17:13:55 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773792834; cv=none;
        d=google.com; s=arc-20240605;
        b=jeFCBVJoWJMACi5k2J9NpMPPZ7igbsaasMBHkTTX8V1JZD/T/rYM1YmZA1kLvrklcr
         RJQtkt2vL56/uCyUDdlKzVbvr+asEKqfgwrOOJupXa+dPyNdwmdE4U/tONpgONhdxVK6
         Sp6ObRbajBbKNhfK4cYnjf2+F3NfKrWiipiN5N05Xu7c98veTzzk/EdWV8fzI+rmHISF
         JElNUBMHMHBwzglnxXmJJKTNuqU0bXllzpQKUiXfMO9jeUF61LzbxyvpCQdYW1w2A5X2
         S+X8cwE95pbP/UDoOXa0laZE84xcKGKVN+HpHHizMwe45aWKblrzTX3P2TC5sLXXV20k
         qIJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=NH3lKMbPGzMjHktQ2S0JYx2HKd1BHzthwHWo0yjIxC8=;
        fh=pjLsieQ+B9sa5Nziw75Pw7b1SLXBjkoch4yGLKApEnU=;
        b=kSdydMSZTmkv8tnmlrYu7upoGjaKAFbJlxt3TlqMQtJVoIRp3CPQBKFvpnOnX6qmsW
         5D0+zxCW+IrJGsZBO6LAfpNn3XskmVyw5Pjg4V2zP60ppjKzZlUXkQiymMc+PTJDQxzB
         QF8Xm9btNSvacRK/wLlzIKLHnnzoEp3T5WhYGseRKxdAyYpfsnr8RqKq3vHaXTXLorHH
         UT5wdpMiLa2GSDct/aVFINsa4L7yQ3QnYTkY1S2GmKk1Ocgi3/97TYs2Qd3u8cKEetHc
         mg/l6g3nL/L50XTqdHEV0YIP6wJh1Ffum0+GOu0TB/X7/bG+22AUKPBzoTgjsRp0gvVF
         uX8w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1773792834; x=1774397634; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NH3lKMbPGzMjHktQ2S0JYx2HKd1BHzthwHWo0yjIxC8=;
        b=QJpi8hKm+xtFPNCyocAfpmRE5NDTUSUH/YPb6X52oBG3vOaTQlISEmrtmhexTkKfI5
         B7UFQYqRYRnFtYPi6wXO2HJJI5BK7Ub2QWMgsZUWMzkFzRyzh0AauncZ8yAblQiuQd9u
         235vzELHXXogtqIH3YTLH5nIv05+uNIPrN4BqTXpI+rEvWTXCcIo3dzDgP78ME7TZdPG
         u0v2UoM7V6GCEpEdCTSfQ9iwAzjneDXx+vcVXkAB+cYsGpX212GDWHCckN37YvO45PVj
         O3KLQ9Wuo+ZOdwU0g5vB2LzXJwI9vy/xwB3s8EMEi/gz5O1cGLPilwoLohlwU2KSnbL2
         1XzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773792834; x=1774397634;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=NH3lKMbPGzMjHktQ2S0JYx2HKd1BHzthwHWo0yjIxC8=;
        b=X6ofed5RTrANFDeRxrbcgxohEwaBLlSzE2PqyxmOCBfv3TMEFSqq7WdipJ+kCCTt2J
         dduu/3jtaMdH4Ka/qQTztkXoaUPv6u16/DPKGwXYuGfFLYjGa4bAiHgdBUj8b7YuCHm3
         r0lDZ82wsqz9R33ENK3kDK47lO7W80RJljPuDD719oB2W5FipT4KdSIHV9CBLwLiDuZI
         N/xXzmVlegyQfscFNvY/Nc+B9VJEE8RU2TWmzh6mI7zQnH7yDBhARk2oopr9QSEiPbDH
         NkPSscPLO3r4ypUW0gBbpQEFeJcY3bk8qeZiGTAZscK3Nin2ujePgMUEJ/E0vQbF14bA
         vvnA==
X-Forwarded-Encrypted: i=1; AJvYcCV6FwQ67D4nBUYmY2gy1mx+Q0cDFkE40muyGrstmKwqGUrPhoHUxdsCMirmpq1Tnl/4DFEZ9Xo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz03zGybUP007vi6702s45HdC+zGKo13evylOueKhBHSOFPaIpE
	rXO0j1iO6nJuI/rPyzbdXGbsa8CGz6Cm+S7mM9CPw/nOF99BOrhj4jCZkslbsN6UjMWnWnGM+Hg
	aP5b1O2qxMqKa9U6cdUxap6cWndovPzuCKZkxOttH
X-Gm-Gg: ATEYQzwal2hEIm48XL1OHrT1ZfuMmV8xFBudV1mijEILNkIlXdv30AgX3b0ht3VoR59
	OvxdfiAhO3cnsvkNSMEKfMc2EdyqcvZJTlNx6n23WlCI9b41UIl/nczi2rK2iGXO3sGHtPKqGl/
	37ifGHAqfPp2vtx5AQnBHimyKU2z05GT5jgLs3bi27RVEtYKI5GVULbIqn7Sn109CUcxgcHo0wM
	mKx+yoKGDyRUk5ImvsgT3CfpTE0PWs8BRDAyvFwCuyWUXd3Nz6XhQRzdLmGNSA0JsGvOYJOVIhc
	Rj7JFr7+0opfJex9Hpo7EZuo626/umGud18=
X-Received: by 2002:a53:acdb:0:20b0:64c:9ee9:7784 with SMTP id
 956f58d0204a3-64e912ea4edmr1596743d50.11.1773792834005; Tue, 17 Mar 2026
 17:13:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260316232819.6872-1-emil.s.tantilov@intel.com> <20260316232819.6872-4-emil.s.tantilov@intel.com>
In-Reply-To: <20260316232819.6872-4-emil.s.tantilov@intel.com>
From: Li Li <boolli@google.com>
Date: Tue, 17 Mar 2026 17:13:41 -0700
X-Gm-Features: AaiRm52502HuPWZDlNe1pVsboDjRd5-YbjXG_qFrypIUllH3EkzzS3xrhNFe7OA
Message-ID: <CAODvEq6ZDoAxzZ4scKtE7tnfe94wBwgTsckEfLzwxFo=BcLNSA@mail.gmail.com>
Subject: Re: [PATCH iwl-net 3/3] idpf: fix PREEMPT_RT raw/bh spinlock nesting
 for async VC handling
To: Emil Tantilov <emil.s.tantilov@intel.com>
Cc: intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org, 
	anthony.l.nguyen@intel.com, aleksandr.loktionov@intel.com, 
	przemyslaw.kitszel@intel.com, andrew+netdev@lunn.ch, davem@davemloft.net, 
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, 
	bigeasy@linutronix.de, clrkwllms@kernel.org, rostedt@goodmis.org, 
	linux-rt-devel@lists.linux.dev, sgzhang@google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-268834-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[16];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[boolli@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,mail.gmail.com:mid]
X-Rspamd-Queue-Id: 6EBBD2B494B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Thank you!

Reviewed-by: Li Li <boolli@google.com>

On Mon, Mar 16, 2026 at 4:28=E2=80=AFPM Emil Tantilov <emil.s.tantilov@inte=
l.com> wrote:
>
> Restructure the ASYNC case to allow calling idpf_vc_xn_forward_reply()
> outside of idpf_vc_xn_lock(). This avoids invalid wait context reported b=
y
> the kernel due to the async handler taking BH spinlock:
>
> [  805.726977] =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> [  805.726991] [ BUG: Invalid wait context ]
> [  805.727006] 7.0.0-rc2-net-devq-031026+ #28 Tainted: G S         OE
> [  805.727026] -----------------------------
> [  805.727038] kworker/u261:0/572 is trying to lock:
> [  805.727051] ff190da6a8dbb6a0 (&vport_config->mac_filter_list_lock){+..=
.}-{3:3}, at: idpf_mac_filter_async_handler+0xe9/0x260 [idpf]
> [  805.727099] other info that might help us debug this:
> [  805.727111] context-{5:5}
> [  805.727119] 3 locks held by kworker/u261:0/572:
> [  805.727132]  #0: ff190da6db3e6148 ((wq_completion)idpf-0000:83:00.0-mb=
x){+.+.}-{0:0}, at: process_one_work+0x4b5/0x730
> [  805.727163]  #1: ff3c6f0a6131fe50 ((work_completion)(&(&adapter->mbx_t=
ask)->work)){+.+.}-{0:0}, at: process_one_work+0x1e5/0x730
> [  805.727191]  #2: ff190da765190020 (&x->wait#34){+.+.}-{2:2}, at: idpf_=
recv_mb_msg+0xc8/0x710 [idpf]
> [  805.727218] stack backtrace:
> ...
> [  805.727238] Workqueue: idpf-0000:83:00.0-mbx idpf_mbx_task [idpf]
> [  805.727247] Call Trace:
> [  805.727249]  <TASK>
> [  805.727251]  dump_stack_lvl+0x77/0xb0
> [  805.727259]  __lock_acquire+0xb3b/0x2290
> [  805.727268]  ? __irq_work_queue_local+0x59/0x130
> [  805.727275]  lock_acquire+0xc6/0x2f0
> [  805.727277]  ? idpf_mac_filter_async_handler+0xe9/0x260 [idpf]
> [  805.727284]  ? _printk+0x5b/0x80
> [  805.727290]  _raw_spin_lock_bh+0x38/0x50
> [  805.727298]  ? idpf_mac_filter_async_handler+0xe9/0x260 [idpf]
> [  805.727303]  idpf_mac_filter_async_handler+0xe9/0x260 [idpf]
> [  805.727310]  idpf_recv_mb_msg+0x1c8/0x710 [idpf]
> [  805.727317]  process_one_work+0x226/0x730
> [  805.727322]  worker_thread+0x19e/0x340
> [  805.727325]  ? __pfx_worker_thread+0x10/0x10
> [  805.727328]  kthread+0xf4/0x130
> [  805.727333]  ? __pfx_kthread+0x10/0x10
> [  805.727336]  ret_from_fork+0x32c/0x410
> [  805.727345]  ? __pfx_kthread+0x10/0x10
> [  805.727347]  ret_from_fork_asm+0x1a/0x30
> [  805.727354]  </TASK>
>
> Fixes: 34c21fa894a1 ("idpf: implement virtchnl transaction manager")
> Reported-by: Ray Zhang <sgzhang@google.com>
> Signed-off-by: Emil Tantilov <emil.s.tantilov@intel.com>
> Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
> ---
>  .../net/ethernet/intel/idpf/idpf_virtchnl.c   | 21 +++++++------------
>  1 file changed, 8 insertions(+), 13 deletions(-)
>
> diff --git a/drivers/net/ethernet/intel/idpf/idpf_virtchnl.c b/drivers/ne=
t/ethernet/intel/idpf/idpf_virtchnl.c
> index 6b9692b30040..8ceabd86e172 100644
> --- a/drivers/net/ethernet/intel/idpf/idpf_virtchnl.c
> +++ b/drivers/net/ethernet/intel/idpf/idpf_virtchnl.c
> @@ -546,32 +546,24 @@ static int
>  idpf_vc_xn_forward_async(struct idpf_adapter *adapter, struct idpf_vc_xn=
 *xn,
>                          const struct idpf_ctlq_msg *ctlq_msg)
>  {
> -       int err =3D 0;
> -
>         if (ctlq_msg->cookie.mbx.chnl_opcode !=3D xn->vc_op) {
>                 dev_err_ratelimited(&adapter->pdev->dev, "Async message o=
pcode does not match transaction opcode (msg: %d) (xn: %d)\n",
>                                     ctlq_msg->cookie.mbx.chnl_opcode, xn-=
>vc_op);
>                 xn->reply_sz =3D 0;
> -               err =3D -EINVAL;
> -               goto release_bufs;
> +               return -EINVAL;
>         }
>
> -       if (xn->async_handler) {
> -               err =3D xn->async_handler(adapter, xn, ctlq_msg);
> -               goto release_bufs;
> -       }
> +       if (xn->async_handler)
> +               return xn->async_handler(adapter, xn, ctlq_msg);
>
>         if (ctlq_msg->cookie.mbx.chnl_retval) {
>                 xn->reply_sz =3D 0;
>                 dev_err_ratelimited(&adapter->pdev->dev, "Async message f=
ailure (op %d)\n",
>                                     ctlq_msg->cookie.mbx.chnl_opcode);
> -               err =3D -EINVAL;
> +               return -EINVAL;
>         }
>
> -release_bufs:
> -       idpf_vc_xn_release_bufs(xn);
> -
> -       return err;
> +       return 0;
>  }
>
>  /**
> @@ -631,7 +623,10 @@ idpf_vc_xn_forward_reply(struct idpf_adapter *adapte=
r,
>                  * can evaluate the response.
>                  */
>                 xn->reply_sz =3D ctlq_msg->data_len;
> +               idpf_vc_xn_unlock(xn);
>                 err =3D idpf_vc_xn_forward_async(adapter, xn, ctlq_msg);
> +               idpf_vc_xn_lock(xn);
> +               idpf_vc_xn_release_bufs(xn);
>                 idpf_vc_xn_unlock(xn);
>                 idpf_vc_xn_push_free(adapter->vcxn_mngr, xn);
>                 return err;
> --
> 2.37.3
>

