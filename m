Return-Path: <netdev+bounces-285057-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mDvRLVq++2nqEAAAu9opvQ
	(envelope-from <netdev+bounces-285057-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 07 May 2026 00:19:06 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CD7F4E12F1
	for <lists+netdev@lfdr.de>; Thu, 07 May 2026 00:19:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 5E9E6300C0F8
	for <lists+netdev@lfdr.de>; Wed,  6 May 2026 22:19:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5BC935838F;
	Wed,  6 May 2026 22:19:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Vyb5+QFv";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="FaKftEUN"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE3A733AD85
	for <netdev@vger.kernel.org>; Wed,  6 May 2026 22:18:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778105942; cv=none; b=e+Ekm8Tdfzfd3scI36wPYZTzUJLyJjUNZ5lNp2dcexjA1NRT28Tyqoalz8PUf0/DSDxaQ7CEP1wFIrIzb49COg2EYQrqRvsHWlOGV+QHEwIGIBnIZwyVqhZCr9OUeurJO5PTJU8i24o/mAIjXbcoQVHDqZ6KgknaiZzTPjl4vk8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778105942; c=relaxed/simple;
	bh=xowx2aws2zk3Zd66+dpqpP2+/Ry8gOTMIEfy3bzK8SA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jmKzyZS94SGZQzMp3an5ZIOhczCZLmN5NrdY553KuhFTEqei333u9wcPgLK5tq8JF54M2Z99Udpbp/INL3jRH8a4FMKoqLfUSQv7BY5q+km9VdVG7uinG1QGjz+ErU/xfJJSrv6JmDzyJ9Mqtex+ObDNYOuJGJ4GJw45p7Qci1A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Vyb5+QFv; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=FaKftEUN; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1778105939;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Y12GQ51sePHfLNuYSwUrWXfEMIUEYmPo7/Zy93R3cDo=;
	b=Vyb5+QFv1kHTf44ad8Cy4KBtvweAEmoTQRfPEpZudq99xQgxxnjBxo1fj9itZ7UOpb53Zd
	4fKQQQcYxbxcZ3y+WosXVLX//JU5GLJ6rkTLZtd9etMOkhGngSr3dTT4U8qfthazmgxxVa
	apNgJNFNQ0enR95uPluy9XuZRDgE2VU=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-483-vp_lM5aON_Oi5gRQZAzfQA-1; Wed, 06 May 2026 18:18:57 -0400
X-MC-Unique: vp_lM5aON_Oi5gRQZAzfQA-1
X-Mimecast-MFC-AGG-ID: vp_lM5aON_Oi5gRQZAzfQA_1778105937
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-44d83e45febso1085220f8f.0
        for <netdev@vger.kernel.org>; Wed, 06 May 2026 15:18:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1778105936; x=1778710736; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Y12GQ51sePHfLNuYSwUrWXfEMIUEYmPo7/Zy93R3cDo=;
        b=FaKftEUNQUx03wHRuNTfvgWO0z+uMESyXEWxvj9dReTLbtNWYwcvv/n8zTXE8vGz9Z
         lfaMf1ycavPovOTfyW7AIVb54SV7zMI287bANsM6vXW3CQM0xB1U7/n13UqGLLHkJ4DR
         rKk8yPslEtVq+M+3Y59JDWE5QDS8KtoBb0VFJ5Pu6h+3TAZ5hZniB4qiIn+Hhxo8Hnfa
         Ej5hcItAV6jTBIUP+S2dV6VQ1sDB2wNiUlpySZD1Q4YOVL/YeQtKkugIZbfdfFzbsJh9
         sksX1WFzwVAAc22TFNM+aXgjTHt44NdaT6aLpy8ofRX3i4u/sp2xM8GGDY4o14Ciuoj+
         ChVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778105936; x=1778710736;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Y12GQ51sePHfLNuYSwUrWXfEMIUEYmPo7/Zy93R3cDo=;
        b=O1eHrJSj/R8L9Tu0znRWTEiHE/deoVHeLb0wQb5A2kYkgVaVgvyaX+YcBPHS7nN4WA
         9lnRjDWrJq4y2Zfao0771uAJbIkpL1TRNBADlz9cFSv/DzR9ucDtKpquGNDKeQr94j2X
         HkYctL2Eo9GosEtsLfunf7zS+gm1qFhW1/btbjU17PZFe48eYHJwlt2E/Ijbwr+4XlgP
         PvXWYv6yPhRAIFLFBDrsRW5I1tRLBr6qigNBx7ZNU6RcyAKtisAle8dGHMBQKZht3+lI
         t+a+tgjqkm/T2ylA1JROHepu4NyLOkGkRSyWbAtluIYDEbyrOqSAnkOG3OqFGwBWpZy5
         MLpg==
X-Forwarded-Encrypted: i=1; AFNElJ+g/T0Dlw8s9XhGYMZGppG0ZFL/wnR79S0Z32ZpTAoTsR5am3WMMnUMrNhKlbre8BC2FArgu5o=@vger.kernel.org
X-Gm-Message-State: AOJu0YzvdBk2Skz5HqrEFXRuRkUHltiwZYGvGfl2VepE22zqpfg3sUVQ
	zuEvs/odbucFDRK8mM+n9Nzk+Y9DlYxhFrjrU3qcOcHsNUlTlrwAAmMapguXFHDg9om3zEF34wo
	omSdb9WOaJr5sTch4Hn0Ex2JrizTGMAEfpviLXiumodHtKapJHmi7PrFHgw==
X-Gm-Gg: AeBDievEheCtGAmijv87QxqV/ZQyG603Ugwt6a7bIF03fZVvQ9TLCTBahgN58MoEiDP
	vnRk27wFgpimnviewFkkGuKtpYHX+bpYfmwh96dDmWndr12ChZ5v5reLSMR06GR5+hSE9L8k6u1
	VK2NRvavLV/8q6C2UUNguSAl5bSSwyHot2tnjqWwzAY7oh4pzbR6CMq27pV1+YayXbOttX17xvt
	aQUmll9w8r+kQtp0OfSZQ4zR+yWHTYjEU7IrNHuIcLEucsnKImjSbAXeA+NL9rXQnBCkerIZFak
	8EVl7v+G+HX3n7WWGfkV7EgorwpR9W637GsFmdtvo0obE6bOYpdNBLbv3EwYA0OCfHrLWrEX04z
	IN1J/K1uxG3J92DGcrlQqr4fOR3MmvzcGNKIddpytsM/jEE8Zdjk=
X-Received: by 2002:a05:6000:2383:b0:43e:a75e:352 with SMTP id ffacd0b85a97d-452e78b35a2mr564060f8f.4.1778105936392;
        Wed, 06 May 2026 15:18:56 -0700 (PDT)
X-Received: by 2002:a05:6000:2383:b0:43e:a75e:352 with SMTP id ffacd0b85a97d-452e78b35a2mr564023f8f.4.1778105935851;
        Wed, 06 May 2026 15:18:55 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-48-7.inter.net.il. [80.230.48.7])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-45052a48f63sm15004698f8f.16.2026.05.06.15.18.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 May 2026 15:18:55 -0700 (PDT)
Date: Wed, 6 May 2026 18:18:51 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Simon Schippers <simon.schippers@tu-dortmund.de>
Cc: willemdebruijn.kernel@gmail.com, jasowang@redhat.com,
	andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, eperezma@redhat.com,
	leiyang@redhat.com, stephen@networkplumber.org, jon@nutanix.com,
	tim.gebauer@tu-dortmund.de, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
	virtualization@lists.linux.dev
Subject: Re: [PATCH net-next v10 1/4] tun/tap: add ptr_ring consume helper
 with netdev queue wakeup
Message-ID: <20260506181556-mutt-send-email-mst@kernel.org>
References: <20260506141033.180450-1-simon.schippers@tu-dortmund.de>
 <20260506141033.180450-2-simon.schippers@tu-dortmund.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260506141033.180450-2-simon.schippers@tu-dortmund.de>
X-Rspamd-Queue-Id: 5CD7F4E12F1
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-285057-lists,netdev=lfdr.de];
	FREEMAIL_CC(0.00)[gmail.com,redhat.com,lunn.ch,davemloft.net,google.com,kernel.org,networkplumber.org,nutanix.com,tu-dortmund.de,vger.kernel.org,lists.linux.dev];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[17];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[redhat.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mst@redhat.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Action: no action

On Wed, May 06, 2026 at 04:10:30PM +0200, Simon Schippers wrote:
> Introduce tun_ring_consume() that wraps ptr_ring_consume() and calls
> __tun_wake_queue(). The latter wakes the stopped netdev subqueue once
> half of the ring capacity has been consumed, tracked via the new
> cons_cnt field in tun_file. cons_cnt is updated while holding the ring
> consumer lock, avoiding races. As a safety net, the queue is also woken
> when the ring becomes empty. The point is to allow the queue to be
> stopped when it gets full, which is required for traffic shaping -
> implemented by the following "avoid ptr_ring tail-drop when a qdisc
> is present". That patch also explains the pairing of the smp_mb()
> of __tun_wake_queue().
> 
> Without the corresponding queue stopping, this patch alone causes no
> regression for a tap setup sending to a qemu VM: 1.132 Mpps
> to 1.144 Mpps.
> 
> Details: AMD Ryzen 5 5600X at 4.3 GHz, 3200 MHz RAM, isolated QEMU
> threads, pktgen sender; Avg over 50 runs @ 100,000,000 packets;
> SRSO and spectre v2 mitigations disabled.
> 
> Co-developed-by: Tim Gebauer <tim.gebauer@tu-dortmund.de>
> Signed-off-by: Tim Gebauer <tim.gebauer@tu-dortmund.de>
> Signed-off-by: Simon Schippers <simon.schippers@tu-dortmund.de>
> ---
>  drivers/net/tun.c | 54 +++++++++++++++++++++++++++++++++++++++++++----
>  1 file changed, 50 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/net/tun.c b/drivers/net/tun.c
> index b183189f1853..00ecf128fe8e 100644
> --- a/drivers/net/tun.c
> +++ b/drivers/net/tun.c
> @@ -145,6 +145,7 @@ struct tun_file {
>  	struct list_head next;
>  	struct tun_struct *detached;
>  	struct ptr_ring tx_ring;
> +	int cons_cnt;
>  	struct xdp_rxq_info xdp_rxq;
>  };
>  
> @@ -557,6 +558,13 @@ void tun_ptr_free(void *ptr)
>  }
>  EXPORT_SYMBOL_GPL(tun_ptr_free);
>  
> +static void tun_reset_cons_cnt(struct tun_file *tfile)
> +{
> +	spin_lock(&tfile->tx_ring.consumer_lock);
> +	tfile->cons_cnt = 0;
> +	spin_unlock(&tfile->tx_ring.consumer_lock);
> +}
> +
>  static void tun_queue_purge(struct tun_file *tfile)
>  {
>  	void *ptr;
> @@ -564,6 +572,7 @@ static void tun_queue_purge(struct tun_file *tfile)
>  	while ((ptr = ptr_ring_consume(&tfile->tx_ring)) != NULL)
>  		tun_ptr_free(ptr);
>  
> +	tun_reset_cons_cnt(tfile);
>  	skb_queue_purge(&tfile->sk.sk_write_queue);
>  	skb_queue_purge(&tfile->sk.sk_error_queue);
>  }
> @@ -730,6 +739,7 @@ static int tun_attach(struct tun_struct *tun, struct file *file,
>  		goto out;
>  	}
>  
> +	tun_reset_cons_cnt(tfile);
>  	tfile->queue_index = tun->numqueues;
>  	tfile->socket.sk->sk_shutdown &= ~RCV_SHUTDOWN;
>  
> @@ -2115,13 +2125,46 @@ static ssize_t tun_put_user(struct tun_struct *tun,
>  	return total;
>  }
>  
> -static void *tun_ring_recv(struct tun_file *tfile, int noblock, int *err)
> +/* Callers must hold ring.consumer_lock */
> +static void __tun_wake_queue(struct tun_struct *tun,
> +			     struct tun_file *tfile, int consumed)
> +{
> +	struct netdev_queue *txq = netdev_get_tx_queue(tun->dev,
> +						tfile->queue_index);
> +
> +	/* Paired with smp_mb__after_atomic() in tun_net_xmit() */
> +	smp_mb();
> +	if (netif_tx_queue_stopped(txq)) {
> +		tfile->cons_cnt += consumed;
> +		if (tfile->cons_cnt >= tfile->tx_ring.size / 2 ||
> +		    __ptr_ring_empty(&tfile->tx_ring)) {
> +			netif_tx_wake_queue(txq);
> +			tfile->cons_cnt = 0;
> +		}
> +	}
> +}
> +
> +static void *tun_ring_consume(struct tun_struct *tun, struct tun_file *tfile)
> +{
> +	void *ptr;
> +
> +	spin_lock(&tfile->tx_ring.consumer_lock);
> +	ptr = __ptr_ring_consume(&tfile->tx_ring);
> +	if (ptr)
> +		__tun_wake_queue(tun, tfile, 1);
> +
> +	spin_unlock(&tfile->tx_ring.consumer_lock);
> +	return ptr;
> +}
> +
> +static void *tun_ring_recv(struct tun_struct *tun, struct tun_file *tfile,
> +			   int noblock, int *err)
>  {
>  	DECLARE_WAITQUEUE(wait, current);
>  	void *ptr = NULL;
>  	int error = 0;
>  
> -	ptr = ptr_ring_consume(&tfile->tx_ring);
> +	ptr = tun_ring_consume(tun, tfile);
>  	if (ptr)
>  		goto out;
>  	if (noblock) {
> @@ -2133,7 +2176,7 @@ static void *tun_ring_recv(struct tun_file *tfile, int noblock, int *err)
>  
>  	while (1) {
>  		set_current_state(TASK_INTERRUPTIBLE);
> -		ptr = ptr_ring_consume(&tfile->tx_ring);
> +		ptr = tun_ring_consume(tun, tfile);
>  		if (ptr)
>  			break;
>  		if (signal_pending(current)) {


So based on commit log I expected all calls to ptr_ring_consume to
be replaced with tun_ring_consume, but it looks like tun_queue_purge
still calls ptr_ring_consume.
I suspect that together with patch 4 it can sometimes leave us stuck
with a stopped queue and an empty ring, forever.





> @@ -2170,7 +2213,7 @@ static ssize_t tun_do_read(struct tun_struct *tun, struct tun_file *tfile,
>  
>  	if (!ptr) {
>  		/* Read frames from ring */
> -		ptr = tun_ring_recv(tfile, noblock, &err);
> +		ptr = tun_ring_recv(tun, tfile, noblock, &err);
>  		if (!ptr)
>  			return err;
>  	}
> @@ -3406,6 +3449,8 @@ static int tun_chr_open(struct inode *inode, struct file * file)
>  		return -ENOMEM;
>  	}
>  
> +	tun_reset_cons_cnt(tfile);
> +
>  	mutex_init(&tfile->napi_mutex);
>  	RCU_INIT_POINTER(tfile->tun, NULL);
>  	tfile->flags = 0;
> @@ -3614,6 +3659,7 @@ static int tun_queue_resize(struct tun_struct *tun)
>  	for (i = 0; i < tun->numqueues; i++) {
>  		tfile = rtnl_dereference(tun->tfiles[i]);
>  		rings[i] = &tfile->tx_ring;
> +		tun_reset_cons_cnt(tfile);
>  	}
>  	list_for_each_entry(tfile, &tun->disabled, next)
>  		rings[i++] = &tfile->tx_ring;
> -- 
> 2.43.0


