Return-Path: <netdev+bounces-281834-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MCf1AzSq8GnOWwEAu9opvQ
	(envelope-from <netdev+bounces-281834-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 28 Apr 2026 14:38:12 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 7429B484F25
	for <lists+netdev@lfdr.de>; Tue, 28 Apr 2026 14:38:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id DD107319C788
	for <lists+netdev@lfdr.de>; Tue, 28 Apr 2026 12:24:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50AEB423A88;
	Tue, 28 Apr 2026 12:21:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QSdIZYaS"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B47340FDA8
	for <netdev@vger.kernel.org>; Tue, 28 Apr 2026 12:21:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777378908; cv=none; b=MvAmqBkhzTuTQV73bW+S7xiUckqM4v8Rqv24DgzwOcj8rVnLX6fDRtrcV0r9M/5lSdO1thz/EVnNoaVeDQhT6uDTPokunz2RtEplyDx5BK1l/yEqVz3zvsu+/yTwp3yZcLK/hL6bxWST2QERJ79SDQlIGlEdAAN5/Ecm7rJidhE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777378908; c=relaxed/simple;
	bh=FMeCLUG9KoolKTPko2XOcJXKf4+KgMohmWU2OBOvJ9A=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=nOPR+q+OH0zNwv3TZoanfLrVB0O0qEg+Th6kuAK06tNYM2n0mSdul5ktwGOaWl+f/Ttn+d4l8D+LiYJqFS138QVwH6P6DI6HiyQ4sEPPWabO+fYRJhKxBs2KbyM2b531PSFgUzMSMhq+iGysrttFRXC5zaOAfSDHemDSYVnKrLs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QSdIZYaS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AD475C2BCB5;
	Tue, 28 Apr 2026 12:21:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777378907;
	bh=FMeCLUG9KoolKTPko2XOcJXKf4+KgMohmWU2OBOvJ9A=;
	h=Date:Subject:To:References:From:In-Reply-To:From;
	b=QSdIZYaSnxj+JmXWRnUHun2pFJjlEHn4qGi4UZJ4NiChe4jnzJTrSMBjdwmsUfDhe
	 14c91yF40nlM0sn270vcf7zklofzQraLGdEy1KAtyyM4ZbkACkdqT2L6a5+0JV/yEe
	 hp+6Xfl7sdcSw0ccp5l+EFnVinI+1A4gOEDPBExt61q1IuWO+drRannz5HTXwVvUE0
	 QBChufhu8nCLKWYBuoMT4tHjxSeKgaMCZ5IZBwbhLfVL20i6z9UBIrUdfZaRpgFbqv
	 ph1WcOVwaTpb9n2sq81KwoTGEbTdm+k1aHDhLVjMHi2x5/Enu0Dl6AX/16ddCKniZs
	 KtNtbqUm6eRZw==
Message-ID: <1499e17a-43bd-4811-bfcc-f5334a62c75f@kernel.org>
Date: Tue, 28 Apr 2026 14:21:43 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Security] NFC: digital: peer-controlled stack overflow in
 digital_in_recv_sensf_res() (sibling to CVE-2026-31622)
To: G <c3bersexnews@gmail.com>, Networking <netdev@vger.kernel.org>,
 Jakub Kicinski <kuba@kernel.org>, David Heidelberg <david@ixit.cz>
References: <CAFqytU96TsqxZpcEtotFG2bP3kr=zwDQz94MonKYmSSL12rbWw@mail.gmail.com>
From: Krzysztof Kozlowski <krzk@kernel.org>
Content-Language: en-US
Autocrypt: addr=krzk@kernel.org; keydata=
 xsFNBFVDQq4BEAC6KeLOfFsAvFMBsrCrJ2bCalhPv5+KQF2PS2+iwZI8BpRZoV+Bd5kWvN79
 cFgcqTTuNHjAvxtUG8pQgGTHAObYs6xeYJtjUH0ZX6ndJ33FJYf5V3yXqqjcZ30FgHzJCFUu
 JMp7PSyMPzpUXfU12yfcRYVEMQrmplNZssmYhiTeVicuOOypWugZKVLGNm0IweVCaZ/DJDIH
 gNbpvVwjcKYrx85m9cBVEBUGaQP6AT7qlVCkrf50v8bofSIyVa2xmubbAwwFA1oxoOusjPIE
 J3iadrwpFvsZjF5uHAKS+7wHLoW9hVzOnLbX6ajk5Hf8Pb1m+VH/E8bPBNNYKkfTtypTDUCj
 NYcd27tjnXfG+SDs/EXNUAIRefCyvaRG7oRYF3Ec+2RgQDRnmmjCjoQNbFrJvJkFHlPeHaeS
 BosGY+XWKydnmsfY7SSnjAzLUGAFhLd/XDVpb1Een2XucPpKvt9ORF+48gy12FA5GduRLhQU
 vK4tU7ojoem/G23PcowM1CwPurC8sAVsQb9KmwTGh7rVz3ks3w/zfGBy3+WmLg++C2Wct6nM
 Pd8/6CBVjEWqD06/RjI2AnjIq5fSEH/BIfXXfC68nMp9BZoy3So4ZsbOlBmtAPvMYX6U8VwD
 TNeBxJu5Ex0Izf1NV9CzC3nNaFUYOY8KfN01X5SExAoVTr09ewARAQABzSVLcnp5c3p0b2Yg
 S296bG93c2tpIDxrcnprQGtlcm5lbC5vcmc+wsGVBBMBCgA/AhsDBgsJCAcDAgYVCAIJCgsE
 FgIDAQIeAQIXgBYhBJvQfg4MUfjVlne3VBuTQ307QWKbBQJoF1BKBQkWlnSaAAoJEBuTQ307
 QWKbHukP/3t4tRp/bvDnxJfmNdNVn0gv9ep3L39IntPalBFwRKytqeQkzAju0whYWg+R/rwp
 +r2I1Fzwt7+PTjsnMFlh1AZxGDmP5MFkzVsMnfX1lGiXhYSOMP97XL6R1QSXxaWOpGNCDaUl
 ajorB0lJDcC0q3xAdwzRConxYVhlgmTrRiD8oLlSCD5baEAt5Zw17UTNDnDGmZQKR0fqLpWy
 786Lm5OScb7DjEgcA2PRm17st4UQ1kF0rQHokVaotxRM74PPDB8bCsunlghJl1DRK9s1aSuN
 hL1Pv9VD8b4dFNvCo7b4hfAANPU67W40AaaGZ3UAfmw+1MYyo4QuAZGKzaP2ukbdCD/DYnqi
 tJy88XqWtyb4UQWKNoQqGKzlYXdKsldYqrLHGoMvj1UN9XcRtXHST/IaLn72o7j7/h/Ac5EL
 8lSUVIG4TYn59NyxxAXa07Wi6zjVL1U11fTnFmE29ALYQEXKBI3KUO1A3p4sQWzU7uRmbuxn
 naUmm8RbpMcOfa9JjlXCLmQ5IP7Rr5tYZUCkZz08LIfF8UMXwH7OOEX87Y++EkAB+pzKZNNd
 hwoXulTAgjSy+OiaLtuCys9VdXLZ3Zy314azaCU3BoWgaMV0eAW/+gprWMXQM1lrlzvwlD/k
 whyy9wGf0AEPpLssLVt9VVxNjo6BIkt6d1pMg6mHsUEVzsFNBFVDXDQBEADNkrQYSREUL4D3
 Gws46JEoZ9HEQOKtkrwjrzlw/tCmqVzERRPvz2Xg8n7+HRCrgqnodIYoUh5WsU84N03KlLue
 MNsWLJBvBaubYN4JuJIdRr4dS4oyF1/fQAQPHh8Thpiz0SAZFx6iWKB7Qrz3OrGCjTPcW6ei
 OMheesVS5hxietSmlin+SilmIAPZHx7n242u6kdHOh+/SyLImKn/dh9RzatVpUKbv34eP1wA
 GldWsRxbf3WP9pFNObSzI/Bo3kA89Xx2rO2roC+Gq4LeHvo7ptzcLcrqaHUAcZ3CgFG88CnA
 6z6lBZn0WyewEcPOPdcUB2Q7D/NiUY+HDiV99rAYPJztjeTrBSTnHeSBPb+qn5ZZGQwIdUW9
 YegxWKvXXHTwB5eMzo/RB6vffwqcnHDoe0q7VgzRRZJwpi6aMIXLfeWZ5Wrwaw2zldFuO4Dt
 91pFzBSOIpeMtfgb/Pfe/a1WJ/GgaIRIBE+NUqckM+3zJHGmVPqJP/h2Iwv6nw8U+7Yyl6gU
 BLHFTg2hYnLFJI4Xjg+AX1hHFVKmvl3VBHIsBv0oDcsQWXqY+NaFahT0lRPjYtrTa1v3tem/
 JoFzZ4B0p27K+qQCF2R96hVvuEyjzBmdq2esyE6zIqftdo4MOJho8uctOiWbwNNq2U9pPWmu
 4vXVFBYIGmpyNPYzRm0QPwARAQABwsF8BBgBCgAmAhsMFiEEm9B+DgxR+NWWd7dUG5NDfTtB
 YpsFAmgXUF8FCRaWWyoACgkQG5NDfTtBYptO0w//dlXJs5/42hAXKsk+PDg3wyEFb4NpyA1v
 qmx7SfAzk9Hf6lWwU1O6AbqNMbh6PjEwadKUk1m04S7EjdQLsj/MBSgoQtCT3MDmWUUtHZd5
 RYIPnPq3WVB47GtuO6/u375tsxhtf7vt95QSYJwCB+ZUgo4T+FV4hquZ4AsRkbgavtIzQisg
 Dgv76tnEv3YHV8Jn9mi/Bu0FURF+5kpdMfgo1sq6RXNQ//TVf8yFgRtTUdXxW/qHjlYURrm2
 H4kutobVEIxiyu6m05q3e9eZB/TaMMNVORx+1kM3j7f0rwtEYUFzY1ygQfpcMDPl7pRYoJjB
 dSsm0ZuzDaCwaxg2t8hqQJBzJCezTOIkjHUsWAK+tEbU4Z4SnNpCyM3fBqsgYdJxjyC/tWVT
 AQ18NRLtPw7tK1rdcwCl0GFQHwSwk5pDpz1NH40e6lU+NcXSeiqkDDRkHlftKPV/dV+lQXiu
 jWt87ecuHlpL3uuQ0ZZNWqHgZoQLXoqC2ZV5KrtKWb/jyiFX/sxSrodALf0zf+tfHv0FZWT2
 zHjUqd0t4njD/UOsuIMOQn4Ig0SdivYPfZukb5cdasKJukG1NOpbW7yRNivaCnfZz6dTawXw
 XRIV/KDsHQiyVxKvN73bThKhONkcX2LWuD928tAR6XMM2G5ovxLe09vuOzzfTWQDsm++9UKF a/A=
In-Reply-To: <CAFqytU96TsqxZpcEtotFG2bP3kr=zwDQz94MonKYmSSL12rbWw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 7429B484F25
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_ALL(0.00)[];
	TAGGED_FROM(0.00)[bounces-281834-lists,netdev=lfdr.de];
	FREEMAIL_TO(0.00)[gmail.com,vger.kernel.org,kernel.org,ixit.cz];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCPT_COUNT_THREE(0.00)[4];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[krzk@kernel.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]

On 28/04/2026 14:05, G wrote:
> Hello,
> 
> I am reporting a peer-controlled stack out-of-bounds write in
> net/nfc/digital_technology.c::digital_in_recv_sensf_res().  The handler
> copies up to ~250 attacker-controlled bytes into the 18-byte stack array
> target.sensf_res of a stack-local struct nfc_target.  A malicious NFC-F
> peer (or NFC-F card emulator) within RF range of a Linux device that is
> polling FELICA via a digital-framework driver triggers the bug with a
> single oversized SENSF response.
> 
> The bug is the missed sibling of CVE-2026-31622 (HIGH 8.8), which fixed

Referring to CVE only obfuscates the process and makes it less credible,
you should refer to the actual commit.

> the analogous NFC-A cascade overflow in digital_in_recv_sdd_res() in the
> same file.  That fix is present in current trees (verified at
> net/nfc/digital_technology.c:427); the SENSF handler was overlooked by
> that audit round and remains unfixed at the time of this report.
> 
> I have a verified end-to-end PoC; the kernel BUG was reproduced on stock
> Ubuntu 6.17.0-22-generic with FORTIFY_SOURCE=y, STACKPROTECTOR_STRONG=y,
> KASLR=y, KASAN=n.
> 
> ================================================================
> Affected kernel version range
> ================================================================
> 
>   - Verified vulnerable: Linux 7.0.1 stable
>     (net/nfc/digital_technology.c:748-800), with end-to-end
>     reproduction performed on Linux 6.17.0-22-generic (Ubuntu).

With which driver? The virtual testing one?

>   - The function body is the same as in current upstream stable
>     releases inspected by the reporter; bisecting the original
>     introduction is left to the maintainer (the reporter does not
>     have a local clone of the full history).

Heh, if you don't want to be judged as sending us LLM slop, I really
suggest to avoid LLM slop products, like speaking about yourself in 3rd
person tense. For me it's an obvious sign.

This should be sent to the mailing lists to all people. Sending this to
me suggests it is some duplicated posting.


>   - Sibling NFC handlers in the same file (sens_res, sdd_res,
>     sensb_res, attrib_res, iso15693_inv_res) already use bounded
>     copies. The NFC-DEP atr_res in net/nfc/digital_dep.c uses a
>     sizeof-based length validation. Only sensf_res lacks an
>     upper-bound check.
> 
> ================================================================
> Description
> ================================================================
> 
> digital_in_recv_sensf_res() validates only the minimum length of the
> incoming SENSF response and then copies resp->len bytes into the
> fixed-size target.sensf_res field of a stack-local struct nfc_target:
> 
>     static void digital_in_recv_sensf_res(struct nfc_digital_dev *ddev,
>                                           void *arg, struct sk_buff *resp)
>     {
>             struct nfc_target target;          /* <-- STACK */
>             ...
>             if (resp->len < DIGITAL_SENSF_RES_MIN_LENGTH) {  /* MIN-only */
>                     rc = -EIO;
>                     goto exit;
>             }
> 
>             if (!DIGITAL_DRV_CAPS_IN_CRC(ddev))
>                     digital_skb_check_crc_f(resp);    /* trims CRC if SW */
> 
>             skb_pull(resp, 1);                          /* -1 byte */
> 
>             memset(&target, 0, sizeof(struct nfc_target));
>             sensf_res = (struct digital_sensf_res *)resp->data;
> 
>             memcpy(target.sensf_res, sensf_res, resp->len);  /* BUG */
>             target.sensf_res_len = resp->len;
>             ...
>     }
> 
> target.sensf_res has fixed size NFC_SENSF_RES_MAXSIZE == 18
> (include/uapi/linux/nfc.h:222).  resp->len is peer-controlled and
> limited only by the on-wire NFC-F LEN byte (1 byte, ~250 bytes
> attacker-controllable after the skb_pull and the optional CRC trim).
> 
> Reachability:
> 
>     peer NFC-F responds to SENSF_REQ
>       -> controller driver (in-tree drivers using
>          nfc_digital_allocate_device(): trf7970a, port100, st95hf,
>          nfcsim)
>         -> nfc_digital RX path
>           -> digital_send_cmd_complete           (workqueue)
>             -> digital_wq_cmd_complete
>               -> cmd->cmd_cb(...)
>                 == digital_in_recv_sensf_res(ddev, NULL, resp)   <-- BUG
> 
> ================================================================
> Conditions
> ================================================================
> 
>   - CONFIG_NFC=y or =m
>   - CONFIG_NFC_DIGITAL=y or =m
>   - A controller driver registered via nfc_digital_allocate_device()
>     (i.e. uses the digital framework, not pure NCI).
>   - User space has started a FELICA / NFC-DEP poll (typically neard).
>   - Adjacent attacker (peer NFC-F device or card emulator within RF
>     range, ~10 cm), or a compromised NFC controller transport.
> 
> NCI-only NFC stacks (controllers that present an NCI interface directly
> to the kernel, e.g. nxp-nci, s3fwrn5, the NCI paths of pn544/st-nci, and
> virtual_ncidev) do not reach this code path.

So you want to say there is no single driver affected by this, right?

> 
> ================================================================
> Reproducer
> ================================================================
> 
> A self-contained out-of-tree kernel module + Python netlink trigger is
> attached as a tarball.  It registers a fake nfc_digital_dev advertising
> NFC_PROTO_FELICA_MASK and NFC_DIGITAL_DRV_CAPS_IN_CRC; its ->in_send_cmd
> op intercepts the framework-issued SENSF_REQ and invokes the
> framework-supplied complete callback (digital_send_cmd_complete) with a
> crafted oversized SENSF response.  No NFC hardware is required; the
> same skb shape comes off the wire from any NFC-F-capable peer.
> 
> Build and run on the test VM:
> 
>     $ make
>     $ sudo modprobe nfc nfc_digital
>     $ sudo insmod ./poc.ko evil_len=200
>     $ sudo python3 ./trigger.py
>     $ sudo dmesg | grep -E -A 30 'fortify|BUG|digital_in_recv_sensf'
> 
> Verified observation on Linux 6.17.0-22-generic (Ubuntu, default config,
> FORTIFY_SOURCE=y, STACKPROTECTOR_STRONG=y, KASLR=y, KASAN=n):
> 
>     poc: delivering evil SENSF_RES, skb->len=200, effective memcpy=199
>          bytes into 18-byte target.sensf_res
>     DIGITAL TX: 06 00 ff ff 00 00
>     DIGITAL RX: c8 01 41 41 41 41 41 41 41 41 41 41 41 41 41 41 ...
> 
>     ------------[ cut here ]------------
>     memcpy: detected buffer overflow: 199 byte write of buffer size 51
>     WARNING: CPU: 0 PID: 515676 at lib/string_helpers.c:1035
>              __fortify_report+0x64/0xc8
>     Workqueue: events digital_wq_cmd_complete [nfc_digital]
>     Call trace:
>      __fortify_report+0x64/0xc8 (P)
>      __fortify_panic+0x14/0x18
>      digital_in_recv_sensf_res+0x26c/0x280 [nfc_digital]
>      digital_wq_cmd_complete+0x80/0x158 [nfc_digital]
>      process_one_work+0x174/0x428
>      worker_thread+0x310/0x440
>      kthread+0x110/0x130
>      ret_from_fork+0x10/0x20
> 
>     ------------[ cut here ]------------
>     kernel BUG at lib/string_helpers.c:1043!
>     Internal error: Oops - BUG: 00000000f2000800 [#1]  SMP
>     [same trace through __fortify_panic -> digital_in_recv_sensf_res+0x26c]
>     note: kworker/0:0[515676] exited with irqs disabled
>     note: kworker/0:0[515676] exited with preempt_count 1
> 
> The full dmesg is attached as observed-dmesg.log.
> 
> ================================================================
> On the FORTIFY "buffer size 51" message
> ================================================================
> 
> __builtin_object_size(target.sensf_res, 0) on a struct member returns
> the bytes from that member to the end of the enclosing object.  In
> struct nfc_target, the byte count from sensf_res[18] to the end is
> 
>     18 (sensf_res) + 1 (hci_reader_gate) + 1 (logical_idx)
>      + 1 (is_iso15693) + 1 (iso15693_dsfid) + 8 (iso15693_uid)
>      + 1 (ats_len) + 20 (ats) = 51
> 
> so FORTIFY catches writes > 51 bytes only.  Writes in the range [19, 51]
> silently corrupt the adjacent fields on FORTIFY=y builds; those values
> propagate into nfc_dev->targets[] via digital_target_found() ->
> nfc_targets_found() and reach user space as NFC_EVENT_TARGETS_FOUND
> attributes.  This means the bug has two distinct effective severities
> even on hardened distro builds:
> 
>     Response length (post-pull)   Outcome on FORTIFY=y, STACKPROTECTOR=y
>     -----------------------------+----------------------------------------
>     <= 18                        | within bounds, no bug
>     19 - 51                      | silent corruption of nfc_target fields
>                                  |   after sensf_res; values reach user
>                                  |   space via netlink
>     52 - ~250                    | __fortify_panic BUG -> kernel oops /
>                                  |   DoS
> 
> ================================================================
> Suspected location and analysis
> ================================================================
> 
>   - Bug site: net/nfc/digital_technology.c:781
>   - Bug class: CWE-787 (Out-of-bounds Write), CWE-121 (Stack-based
>     Buffer Overflow).
>   - Severity: pre-auth, AV:A.  CVSS 3.1 baseline (pure DoS, the
>     confirmed outcome on every hardened build):
>         AV:A/AC:L/PR:N/UI:N/S:U/C:N/I:N/A:H = 6.5 (MEDIUM)

If there is no driver, severity is LOW.

>     If the [19, 51] silent corruption surfacing via
>     NFC_EVENT_TARGETS_FOUND netlink events is counted as integrity
>     impact, the vector becomes
>         AV:A/AC:L/PR:N/UI:N/S:U/C:N/I:L/A:H = 7.1 (HIGH)
>     Upgrade path to ~8.8 (matching the precedent CVE-2026-31622)
>     only on builds without FORTIFY_SOURCE / STACKPROTECTOR if RCE
>     is demonstrated; we have not constructed that exploit.  This
>     is NOT a local privilege escalation primitive.
>   - Sibling audit (verified by inspection):
>         digital_in_recv_sens_res         (digital_technology.c:482)
>             resp->len < sizeof(u16) check; reads u16, no
>             peer-controlled memcpy into target              OK
>         digital_in_recv_sdd_res          (digital_technology.c:387)
>             target->nfcid1_len + size > NFC_NFCID1_MAXSIZE
>             cap before memcpy at line 427 (CVE-2026-31622
>             fix)                                            OK
>         digital_in_recv_sensb_res        (digital_technology.c:651)
>             resp->len != sizeof(*sensb_res) strict size
>             match; no peer-controlled memcpy into target    OK
>         digital_in_recv_attrib_res       (digital_technology.c:581)
>             resp->len < sizeof(*attrib_res); reads fields
>             only                                            OK
>         digital_in_recv_iso15693_inv_res (digital_technology.c:843)
>             resp->len != sizeof(*res); memcpy into
>             target->iso15693_uid is dest-bound              OK
>         digital_in_recv_atr_res          (digital_dep.c:399)
>             resp->len < sizeof(*atr_res); remaining bytes
>             go via nfc_set_remote_general_bytes (separate
>             validation, not direct-memcpy pattern)          OK
>         digital_in_recv_sensf_res        (digital_technology.c:748)
>             MIN-only check; no MAX cap before memcpy at
>             line 781                                        BUG
>     digital_in_recv_sensf_res() is the lone outlier in the
>     peer-controlled-length-to-nfc_target-memcpy pattern audited
>     here.
> 
> ================================================================
> Proposed fix
> ================================================================
> 
> Add a maximum-length check, mirroring the bounded pattern already used
> in every sibling handler in the same file:
> 
> --- a/net/nfc/digital_technology.c
> +++ b/net/nfc/digital_technology.c
> @@ -762,7 +762,12 @@ static void digital_in_recv_sensf_res(struct
> nfc_digital_dev *ddev, void *arg,
>         if (resp->len < DIGITAL_SENSF_RES_MIN_LENGTH) {
>                 rc = -EIO;
>                 goto exit;
>         }
> 
> +       if (resp->len > NFC_SENSF_RES_MAXSIZE) {
> +               rc = -EIO;
> +               goto exit;
> +       }
> +
>         if (!DIGITAL_DRV_CAPS_IN_CRC(ddev)) {
>                 rc = digital_skb_check_crc_f(resp);
> 
> Signed-off-by: <your name and email here>

Do you want to send a proper Linux patch for it with proper authorship
(see submitting patches)?

Best regards,
Krzysztof

