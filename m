Return-Path: <netdev+bounces-267774-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +n98MxGRtWl62AAAu9opvQ
	(envelope-from <netdev+bounces-267774-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 14 Mar 2026 17:47:13 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 236BA28DF67
	for <lists+netdev@lfdr.de>; Sat, 14 Mar 2026 17:47:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DE5B0302F721
	for <lists+netdev@lfdr.de>; Sat, 14 Mar 2026 16:47:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFB3922332E;
	Sat, 14 Mar 2026 16:47:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="htLoQjoF"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C5F31A680E;
	Sat, 14 Mar 2026 16:47:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773506829; cv=none; b=nxqLAyezfDSlyLL4903ozw0+To89vS0H3SJKAmcTig7jAbgQKilsBDFPUww1UAct13V85pnxnLTGKsP8xdPpJre3l/ESL/gTkMwgtBb8ZRL90/OG8C6jflBBZcIP85TjW2qZG71HrbMVaSl1agmW5KxV51XEvEtTu6BqDxQ7C/M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773506829; c=relaxed/simple;
	bh=L60FvIiXbFdesN8xzD4jJjoJUuPNwVumOSgWcgty+hU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CzngW7pH3jAg5ht9LfE6JvRNee1wz0QLtFzb7NQbanJQSK0X9JY4kHxq56+ynVUQ61QVyn7BTyl2cI4CxsnJcyXPBtn1My7cHZ2m7YOzIA/bwTQRd668Dcicz2wXmH+/9/MXoNqb+g/GDtN9AnualJmOFXuRcUDdzvAOR5BHWNU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=htLoQjoF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E8AA6C116C6;
	Sat, 14 Mar 2026 16:47:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773506829;
	bh=L60FvIiXbFdesN8xzD4jJjoJUuPNwVumOSgWcgty+hU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=htLoQjoFgpE7QupUmnQBWnZgRq1y5ZLzeK44FprJQkBMhcGG1L7By9Fo0AWW2uexK
	 zf4bFzHIZFjOCZd6jvwL3erlS+vrSrmNnWJaj7GLzB7FoMcgbVY/rwD3HN/Hs2js8t
	 ehn0D68Afrb7srsPZ+vm1TKHswKjlL/uLTYiTeP+10LAv3bBIeb/EgYd+SmxN1GOIZ
	 WjgNxNA5xqs5S7bNnPiE6+BOlyznrBkV1cSzM9vWpfg2qU5+LZJya0DRSV8P8kf//R
	 3ZK+kRW9ziNjcNmJWq8iHRZrHWI7Ba9FbgA/SPMnwz97leGdAFdyOerHT2uWct6H1B
	 sCFQZdLgqbysA==
Date: Sat, 14 Mar 2026 09:47:07 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: davem@davemloft.net, linux-bluetooth@vger.kernel.org,
 netdev@vger.kernel.org
Subject: Re: [GIT PULL] bluetooth 2026-03-12
Message-ID: <20260314094707.105683b1@kernel.org>
In-Reply-To: <20260312200655.1215688-1-luiz.dentz@gmail.com>
References: <20260312200655.1215688-1-luiz.dentz@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-267774-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	RCPT_COUNT_THREE(0.00)[4];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: 236BA28DF67
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Thu, 12 Mar 2026 16:06:54 -0400 Luiz Augusto von Dentz wrote:
>  - hci_sync: Fix hci_le_create_conn_sync
>  - MGMT: Fix list corruption and UAF in command complete handlers
>  - L2CAP: Disconnect if received packet's SDU exceeds IMTU
>  - L2CAP: Disconnect if sum of payload sizes exceed SDU
>  - L2CAP: Fix accepting multiple L2CAP_ECRED_CONN_REQ
>  - L2CAP: Fix type confusion in l2cap_ecred_reconf_rsp()
>  - L2CAP: Validate L2CAP_INFO_RSP payload length before access
>  - L2CAP: Fix use-after-free in l2cap_unregister_user
>  - ISO: Fix defer tests being unstable
>  - HIDP: Fix possible UAF
>  - SMP: make SM/PER/KDU/BI-04-C happy
>  - qca: fix ROM version reading on WCN3998 chips

FWIW this is what our AI had to say about the series, mostly nit picks
but not all (LMK if you want me to hook the AI reviewer up to your
patchwork):

================================================================================
PATCH 1/12
================================================================================
commit e1d9a66889867c232657a9b6f25d451d7c3ab96f
Author: Christian Eggers <ceggers@arri.de>

Bluetooth: LE L2CAP: Disconnect if received packet's SDU exceeds IMTU

This commit adds proper validation and disconnect handling when received
L2CAP SDU length exceeds the receiver's MTU, fixing compliance test
L2CAP/LE/CFC/BV-26-C.

> Fixes: aac23bf63659 ("Bluetooth: Implement LE L2CAP reassembly")

The Fixes: tag points to commit aac23bf63659 ("Bluetooth: Implement LE
L2CAP reassembly"), but the function being fixed, l2cap_ecred_data_rcv(),
was created in commit 15f02b910562 ("Bluetooth: L2CAP: Add initial code
for Enhanced Credit Based Mode"). While aac23bf63659 introduced a similar
bug in the older l2cap_le_data_rcv() function, shouldn't the Fixes: tag
point to the commit that introduced the specific function being fixed?

Suggested: Fixes: 15f02b910562 ("Bluetooth: L2CAP: Add initial code for
Enhanced Credit Based Mode")

> diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
> index ad98db9632fd..3056dcd5fa2f 100644
> --- a/net/bluetooth/l2cap_core.c
> +++ b/net/bluetooth/l2cap_core.c

[ ... ]

> @@ -6689,7 +6691,9 @@ static int l2cap_ecred_data_rcv(struct l2cap_chan *chan, struct sk_buff *skb)
>  		       sdu_len, skb->len, chan->imtu);
>
>  		if (sdu_len > chan->imtu) {
> -			BT_ERR("Too big LE L2CAP SDU length received");
> +			BT_ERR("Too big LE L2CAP SDU length: len %u > %u",
> +			       skb->len, sdu_len);
> +			l2cap_send_disconn_req(chan, ECONNRESET);
>  			err = -EMSGSIZE;
>  			goto failed;
>  		}

The error message prints skb->len and sdu_len, but the condition checks
sdu_len > chan->imtu. This is inconsistent with the first hunk of this
patch, which correctly prints the two values being compared:

net/bluetooth/l2cap_core.c:l2cap_ecred_data_rcv() {
    if (skb->len > chan->imtu) {
        BT_ERR("Too big LE L2CAP PDU: len %u > %u", skb->len,
               chan->imtu);
        ...
    }
}

Shouldn't the second error message follow the same pattern and print
sdu_len and chan->imtu instead?



================================================================================
PATCH 2/12
================================================================================
commit b6a2bf43aa37670432843bc73ae2a6288ba4d6f8
Author: Christian Eggers <ceggers@arri.de>

Bluetooth: LE L2CAP: Disconnect if sum of payload sizes exceed SDU

This commit adds a disconnect call when the sum of payload sizes for
K-frames exceeds the specified SDU length, addressing test case
L2CAP/LE/CFC/BV-27-C as specified in Core 6.0, Vol 3, Part A, 3.4.3.

> Fixes: aac23bf63659 ("Bluetooth: Implement LE L2CAP reassembly")

Does the Fixes: tag point to the correct commit? The current fix modifies
l2cap_ecred_data_rcv(), which was introduced in commit 15f02b910562
("Bluetooth: L2CAP: Add initial code for Enhanced Credit Based Mode"),
not in aac23bf63659.

Should the Fixes: tag be: Fixes: 15f02b910562 ("Bluetooth: L2CAP: Add
initial code for Enhanced Credit Based Mode")?



================================================================================
PATCH 3/12 - No review comments
================================================================================

================================================================================
PATCH 4/12 - No review comments
================================================================================

================================================================================
PATCH 5/12 - No review comments
================================================================================

================================================================================
PATCH 6/12
================================================================================
commit 17f89341cb4281d1da0e2fb0de5406ab7c4e25ef
Author: Wang Tao <wangtao554@huawei.com>

Bluetooth: MGMT: Fix list corruption and UAF in command complete handlers

This commit addresses two issues from the 302a1f674c00 rework that
changed mgmt_pending_valid() semantics: fixing double list_del() in
mgmt_add_adv_patterns_monitor_complete() and removing incorrect
mgmt_pending_foreach() usage in set_mesh_complete().

> diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
> index a7238fd3b03b..d52238ce6a9a 100644
> --- a/net/bluetooth/mgmt.c
> +++ b/net/bluetooth/mgmt.c

[ ... ]

> @@ -5377,7 +5374,7 @@ static void mgmt_add_adv_patterns_monitor_complete(struct hci_dev *hdev,
>
>  	mgmt_cmd_complete(cmd->sk, cmd->hdev->id, cmd->opcode,
>  			  mgmt_status(status), &rp, sizeof(rp));
> -	mgmt_pending_remove(cmd);
> +	mgmt_pending_free(cmd);
>
>  	hci_dev_unlock(hdev);
>  	bt_dev_dbg(hdev, "add monitor %d complete, status %d",

Is this change actually correct? Looking at the function entry condition:

    if (status == -ECANCELED && !mgmt_pending_valid(hdev, cmd))
        return;

Due to short-circuit evaluation of '&&', mgmt_pending_valid() is only
called when status == -ECANCELED. On the normal completion path (status !=
-ECANCELED), mgmt_pending_valid() is never executed, so cmd remains linked
in hdev->mgmt_pending.

Calling mgmt_pending_free(cmd) here would kfree(cmd) without unlinking it
from the list first, leaving a dangling pointer. Any subsequent list
traversal (e.g., mgmt_pending_foreach during __mgmt_power_off, or another
mgmt_pending_valid call) would dereference freed memory.

Compare this to other MGMT completion handlers which use '||' instead:

    if (err == -ECANCELED || !mgmt_pending_valid(hdev, cmd))
        return;

With '||', mgmt_pending_valid() always executes on the normal path and
unlinks cmd from the list, making mgmt_pending_free(cmd) safe. Should this
function's early return condition be changed to use '||' to match the other
handlers?



================================================================================
PATCH 7/12
================================================================================
commit dbf666e4fc9bdd975a61bf682b3f75cb0145eedd
Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

Bluetooth: HIDP: Fix possible UAF

This fixes the use-after-free caused by not dropping the l2cap_conn
reference when the user->remove callback is called. The patch drops the
l2cap_conn reference in hidp_session_remove() and adds NULL checks in
both session_free() and hidp_session_thread().

> diff --git a/net/bluetooth/hidp/core.c b/net/bluetooth/hidp/core.c
> index 6fe815241b01..7bcf8c5ceaee 100644
> --- a/net/bluetooth/hidp/core.c
> +++ b/net/bluetooth/hidp/core.c

[ ... ]

> @@ -1164,6 +1165,15 @@ static void hidp_session_remove(struct l2cap_conn *conn,
>
>  	down_write(&hidp_session_sem);
>
> +	/* Drop L2CAP reference immediately to indicate that
> +	 * l2cap_unregister_user() shall not be called as it is already
> +	 * considered removed.
> +	 */
> +	if (session->conn) {
> +		l2cap_conn_put(session->conn);
> +		session->conn = NULL;
> +	}
> +
>  	hidp_session_terminate(session);
>
>  	cancel_work_sync(&session->dev_init);

Does setting session->conn = NULL in hidp_session_remove() create a
race with hidp_connection_del()?

Before this patch, session->conn was always a valid pointer (initialized
in hidp_session_new() and only released in session_free()). After this
patch, hidp_session_remove() sets session->conn = NULL.

Looking at hidp_connection_del():

int hidp_connection_del(struct hidp_conndel_req *req)
{
	...
	session = hidp_session_find(&req->bdaddr);
	if (!session)
		return -ENOENT;

	if (req->flags & BIT(HIDP_VIRTUAL_CABLE_UNPLUG))
		hidp_send_ctrl_message(session, ...);
	else
		l2cap_unregister_user(session->conn, &session->user);

	hidp_session_put(session);
	return 0;
}

After hidp_session_find() releases hidp_session_sem, there's no
protection preventing hidp_session_remove() from running concurrently and
setting session->conn = NULL.

If hidp_session_remove() runs between the hidp_session_find() return and
the l2cap_unregister_user() call, then l2cap_unregister_user() receives a
NULL conn pointer and immediately dereferences it in its first line:

	struct hci_dev *hdev = conn->hcon->hdev;

causing a NULL pointer dereference.

> @@ -1301,7 +1311,9 @@ static int hidp_session_thread(void *arg)
>  	 * Instead, this call has the same semantics as if user-space tried to
>  	 * delete the session.
>  	 */
> -	l2cap_unregister_user(session->conn, &session->user);
> +	if (session->conn)
> +		l2cap_unregister_user(session->conn, &session->user);
> +
>  	hidp_session_put(session);
>
>  	module_put_and_kthread_exit(0);




================================================================================
PATCH 8/12
================================================================================
commit 752a6c9596dd25efd6978a73ff21f3b592668f4a
Author: Shaurya Rane <ssrane_b23@ee.vjti.ac.in>

Bluetooth: L2CAP: Fix use-after-free in l2cap_unregister_user

This patch addresses a use-after-free bug reported by syzbot where
l2cap_unregister_user() dereferences conn->hcon->hdev after the hci_dev
structure has been freed. The fix switches from hci_dev_lock to conn->lock
in both l2cap_register_user() and l2cap_unregister_user().

Closes: https://syzkaller.appspot.com/bug?extid=14b6d57fb728e27ce23c

> Bluetooth: L2CAP: Fix use-after-free in l2cap_unregister_user
>
> After commit ab4eedb790ca ("Bluetooth: L2CAP: Fix corrupted list in
> hci_chan_del"), l2cap_conn_del() uses conn->lock to protect access to
> conn->users. However, l2cap_register_user() and l2cap_unregister_user()
> don't use conn->lock, creating a race condition where these functions can
> access conn->users and conn->hchan concurrently with l2cap_conn_del().
>
> This can lead to use-after-free and list corruption bugs, as reported
> by syzbot.

Does the commit message accurately describe the syzbot-reported bug?

The syzbot report (syzbot+14b6d57fb728e27ce23c) shows a use-after-free in
l2cap_unregister_user at the mutex_lock_nested call. The actual crash
happens because the hci_dev structure (accessed via conn->hcon->hdev)
was already freed when l2cap_unregister_user tried to lock it with
hci_dev_lock(hdev):

Crash site:
  l2cap_unregister_user -> hci_dev_lock(hdev)
  where hdev = conn->hcon->hdev

Freed by:
  hci_release_dev -> kfree()
  via vhci_release -> hci_free_dev -> kobject_put -> hci_release_dev

The freed object is an 8192-byte kmalloc slab (hci_dev), and the crash
task is khidpd_* (hidp_session_thread).

The commit message states "This can lead to use-after-free and list
corruption bugs, as reported by syzbot." While the theoretical race on
conn->users IS possible, the actual syzbot-reported crash is about
accessing freed hdev memory when trying to acquire hci_dev_lock, not
about conn->users list corruption or conn->hchan use-after-free.

>
> Fix this by changing l2cap_register_user() and l2cap_unregister_user()
> to use conn->lock instead of hci_dev_lock(), ensuring consistent locking
> for the l2cap_conn structure.
>
> Reported-by: syzbot+14b6d57fb728e27ce23c@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=14b6d57fb728e27ce23c
> Fixes: ab4eedb790ca ("Bluetooth: L2CAP: Fix corrupted list in hci_chan_del")
> Signed-off-by: Shaurya Rane <ssrane_b23@ee.vjti.ac.in>
> Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
>
> diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
> index 0f400051f093..780136e18aae 100644
> --- a/net/bluetooth/l2cap_core.c
> +++ b/net/bluetooth/l2cap_core.c
> @@ -1678,17 +1678,15 @@ static void l2cap_info_timeout(struct work_struct *work)
>
>  int l2cap_register_user(struct l2cap_conn *conn, struct l2cap_user *user)
>  {
> -	struct hci_dev *hdev = conn->hcon->hdev;
>  	int ret;
>
>  	/* We need to check whether l2cap_conn is registered. If it is not, we
> -	 * must not register the l2cap_user. l2cap_conn_del() is unregisters
> -	 * l2cap_conn objects, but doesn't provide its own locking. Instead, it
> -	 * relies on the parent hci_conn object to be locked. This itself relies
> -	 * on the hci_dev object to be locked. So we must lock the hci device
> -	 * here, too. */
> +	 * must not register the l2cap_user. l2cap_conn_del() unregisters
> +	 * l2cap_conn objects under conn->lock, and we use the same lock here
> +	 * to protect access to conn->users and conn->hchan.
> +	 */

Does the new comment fully explain the reason for the change?

The comment states that l2cap_conn_del() unregisters l2cap_conn objects
under conn->lock, and we use the same lock to protect conn->users and
conn->hchan. This is factually correct.

However, the comment omits the actual reason for changing the locking:
the old code dereferenced conn->hcon->hdev to acquire hci_dev_lock,
but hci_dev can be freed before this point, causing the use-after-free
crash that syzbot reported.

The comment describes a secondary benefit (consistent locking for
conn->users and conn->hchan) rather than the primary bug being fixed
(accessing a freed hci_dev structure through conn->hcon->hdev).

>
> -	hci_dev_lock(hdev);
> +	mutex_lock(&conn->lock);
>
>  	if (!list_empty(&user->list)) {
>  		ret = -EINVAL;

[ ... ]



================================================================================
PATCH 9/12 - No review comments
================================================================================

================================================================================
PATCH 10/12 - No review comments
================================================================================

================================================================================
PATCH 11/12 - No review comments
================================================================================

================================================================================
PATCH 12/12 - No review comments
================================================================================

